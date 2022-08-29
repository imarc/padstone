<?php

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
];