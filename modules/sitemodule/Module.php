<?php
namespace modules\sitemodule;

use Craft;
use yii\base\Event;
use yii\web\Response;

use craft\elements\Entry;
use craft\events\RegisterTemplateRootsEvent;
use craft\events\TemplateEvent;
use craft\i18n\PhpMessageSource;
use craft\web\View;

use yii\web\BadRequestHttpException;
use craft\helpers\App;
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

        // Set the controllerNamespace based on whether this is a console or web request
        if (Craft::$app->getRequest()->getIsConsoleRequest()) {
            $this->controllerNamespace = 'modules\\sitemodule\\console\\controllers';
        } else {
            $this->controllerNamespace = 'modules\\sitemodule\\controllers';
        }

        // Enable this if site is multisite with multiple TLDs to fix issues with multiple TLDs in Craft live preview and enable block in config/app.web.php (and remove Content-Security-Policy header from .htaccess)
        // Remove X-Frame-Options for Live Preview (Blitz/CloudFront may serve responses that bypass .htaccess)
        // Event::on(
        //     Response::class,
        //     Response::EVENT_BEFORE_SEND,
        //     function () {
        //         if (Craft::$app->getRequest()->getIsLivePreview()) {
        //             Craft::$app->getResponse()->getHeaders()->remove('X-Frame-Options');
        //         }
        //     }
        // );

        // Custom initialization code goes here...
        parent::init();
    }
}
