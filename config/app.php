<?php
/**
 * Yii Application Config
 *
 * Edit this file at your own risk!
 *
 * The array returned by this file will get merged with
 * vendor/craftcms/cms/src/config/app.php and app.[web|console].php, when
 * Craft's bootstrap script is defining the configuration for the entire
 * application.
 *
 * You can define custom modules and system components, and even override the
 * built-in system components.
 *
 * If you want to modify the application config for *only* web requests or
 * *only* console requests, create an app.web.php or app.console.php file in
 * your config/ folder, alongside this one.
 * 
 * Read more about application configuration:
 * https://craftcms.com/docs/5.x/reference/config/app.html
 */

use craft\helpers\App;

return [
    'modules' => [
        'site-module' => [
            'class' => \modules\sitemodule\Module::class
        ]
    ],
    'bootstrap' => [
        'site-module'
    ],
    'components' => [
        'redis' => [
            'class'    => 'yii\redis\Connection',
            'hostname' => App::env('REDIS_HOSTNAME') ?: 'redis',
            'port'     => App::env('REDIS_PORT') ?: 6379,
            'database' => App::env('REDIS_DATABASE') ?: 0,
        ],
        'cache' => [
            'class' => yii\redis\Cache::class,
            'defaultDuration' => 86400,
            'enableReplicas' => false,
            'keyPrefix' => App::env('REDIS_KEY_PREFIX'),
        ],
        'mutex' => [
            'mutex' => 'yii\redis\Mutex'
        ],
    ],
];
