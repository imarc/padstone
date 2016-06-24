<?php
namespace Craft;

class ImarcDashboard_SupportInfoWidget extends BaseWidget
{
    public function getName()
    {
        return Craft::t('Imarc Support Info');
    }

    public function getBodyHtml()
    {
        return craft()->templates->render(
            'imarcdashboard/supportinfo'
        );
    }
}
