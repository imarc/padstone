<?php
/**
 * Yii Application Config
 *
 * Edit this file at your own risk!
 *
 * The array returned by this file will get merged with
 * vendor/craftcms/cms/src/config/app/main.php and [web|console].php, when
 * the Craft's bootstrap script is defining the configuration for the entire
 * application.
 *
 * You can define custom modules and system components, and even override the
 * built-in system components.
 */

return [
    'modules' => [
        'my-module' => \modules\Module::class,
    ],
    'components' => [
        /* overloads the default PHP session path */
        'session' => [
            'name' => 'PHPSESSID',
            'as session' => craft\behaviors\SessionBehavior::class,
            'savePath' => str_replace('/web', '/session', $_SERVER['DOCUMENT_ROOT']), 
        ],
    ],
];
