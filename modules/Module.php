<?php
namespace modules;

use Craft;
use modules\twigextensions\ArrayExtension;
use modules\twigextensions\CookieExtension;
use modules\twigextensions\InflectionExtension;
use modules\twigextensions\LinkingExtension;
use modules\twigextensions\PathingVariablesExtension;
use modules\twigextensions\WrapEmbedsExtension;

/**
 * Custom module class.
 *
 * This class will be available throughout the system via:
 * `Craft::$app->getModule('my-module')`.
 *
 * You can change its module ID ("my-module") to something else from
 * config/app.php.
 *
 * If you want the module to get loaded on every request, uncomment this line
 * in config/app.php:
 *
 *     'bootstrap' => ['my-module']
 *
 * Learn more about Yii module development in Yii's documentation:
 * http://www.yiiframework.com/doc-2.0/guide-structure-modules.html
 */
class Module extends \yii\base\Module
{
    /**
     * Initializes the module.
     */
    public function init()
    {
	    Craft::setAlias('@modules', __DIR__);
        parent::init();

        // Set a @modules alias pointed to the modules/ directory
        Craft::setAlias('@modules', __DIR__);

        // Set the controllerNamespace based on whether this is a console or web request
        if (Craft::$app->getRequest()->getIsConsoleRequest()) {
            $this->controllerNamespace = 'modules\\console\\controllers';
        } else {
            $this->controllerNamespace = 'modules\\controllers';
        }


        // Custom initialization code goes here...
        if (Craft::$app->getRequest()->getIsSiteRequest()) {
            $devMode = (boolean) Craft::$app->config->getConfigSettings('general')->devMode;
            if ($devMode) {
                Craft::$app->view->twig->setCache(false);
            }

            // Instantiate + register our local twig extention
            Craft::$app->view->registerTwigExtension(new ArrayExtension());
            Craft::$app->view->registerTwigExtension(new CookieExtension());
            Craft::$app->view->registerTwigExtension(new InflectionExtension());
            Craft::$app->view->registerTwigExtension(new LinkingExtension());
            Craft::$app->view->registerTwigExtension(new PathingVariablesExtension());
            Craft::$app->view->registerTwigExtension(new WrapEmbedsExtension());

            Event::on(
                CraftVariable::class,
                CraftVariable::EVENT_INIT,
                function (Event $event) {
                    /** @var CraftVariable $variable */
                    $variable = $event->sender;
                    $variable->set('kindling', KindlingVariable::class);
                }
            );
        }
    }
}
