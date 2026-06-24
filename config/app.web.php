<?php
use craft\filters\Headers;
use craft\helpers\App;

return [
    'components' => [
        'session' => function() {
            $config = craft\helpers\App::sessionConfig();

            $config['class'] = yii\web\DbSession::class;

            $config['as session'] = craft\behaviors\SessionBehavior::class;

            $config['sessionTable'] = craft\db\Table::PHPSESSIONS;

            return Craft::createObject($config);
        },
    ],

    // Enable this if site is multisite with multiple TLDs to fix issues with multiple TLDs in Craft live preview
    // Attach the headers filter to the application:
    // 'as headersFilter' => [
    //     'class' => Headers::class,
    //     'headers' => [
    //         'Content-Security-Policy' => join(' ', [
    //           'frame-ancestors',
    //           "'self'",
    //           App::env('PRIMARY_SITE_URL'),
    //         ]),
    //     ],
    // ],
];