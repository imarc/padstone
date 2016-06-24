<?php

namespace Craft;

/**
 * Imarc Dashboard Plugin. This is a fork of the One Dashboard Plugin by Bob
 * Olde Hampsink where we've added our one widgets.
 */
class ImarcDashboardPlugin extends BasePlugin
{
    /**
     * Get plugin name.
     *
     * @return string
     */
    public function getName()
    {
        return Craft::t('Imarc Dashboard');
    }

    /**
     * Get plugin version.
     *
     * @return string
     */
    public function getVersion()
    {
        return '0.1.0';
    }

    /**
     * Get plugin developer.
     *
     * @return string
     */
    public function getDeveloper()
    {
        return 'Imarc';
    }

    /**
     * Get plugin developer url.
     *
     * @return string
     */
    public function getDeveloperUrl()
    {
        return 'https://www.imarc.com';
    }

    /**
     * Init dashboard check early.
     */
    public function init()
    {
        // Don't run when in console
        if (!craft()->isConsole()) {

            // Get current user
            $currentUser = craft()->userSession->getUser();

            // Make sure we're logged in onto CP
            if ($currentUser && $currentUser->can('accessCp') && craft()->request->isCpRequest()) {

                // Check if this user already has widgets
                $userWidgetRecords = WidgetRecord::model()->ordered()->findAllByAttributes(array(
                    'userId' => $currentUser->id,
                ));

                if (!$userWidgetRecords) {

                    // Get enabled admin widgets
                    $adminWidgetRecords = WidgetRecord::model()->ordered()->findAllByAttributes(array(
                        'userId' => 1,
                        'enabled' => 1,
                    ));

                    // Populate widget models
                    $adminWidgets = WidgetModel::populateModels($adminWidgetRecords);

                    // Loop through widget models
                    foreach ($adminWidgets as $widget) {

                        // Clear widget id
                        $widget->id = null;

                        // Save on user
                        $result = craft()->dashboard->saveUserWidget($widget);

                        // If that worked then we should have an id on the model
                        // and can go ahead and update the colspan
                        if ($result && $widget->id) {
                            craft()->dashboard->changeWidgetColspan($widget->id, $widget->colspan);
                        }
                    }
                }
            }
        }
    }
}
