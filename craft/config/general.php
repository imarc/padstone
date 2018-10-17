<?php

/**
 * General Configuration
 *
 * This is an example configuration file provided by Padstone that demonstrates
 * per environment configuration.
 * You can see a list of the default settings in craft/app/etc/config/defaults/general.php
 */

require_once dirname(CRAFT_BASE_PATH) . '/vendor/autoload.php';

// load env() helper method
Env::init();

// Initialize environment variables
try {
    $dotenv = new Dotenv\Dotenv(dirname(CRAFT_BASE_PATH));

    $dotenv->load();

    $dotenv->required([
        'DB_HOST',
        'DB_USER',
        'DB_NAME',
        'CRAFT_SITEURL',
        'CRAFT_SITENAME'
    ])->notEmpty();
} catch (Exception $e) {
    die($e->getMessage());
}

$scheme = 'http';

if (
    isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on' ||
    $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https'
) {
    $scheme = 'https';
}

$config = [
    'omitScriptNameInUrls' => true,
    'maxUploadFileSize' => 104857600,
    'devMode' => env('CRAFT_DEVMODE', false),
    'testToEmailAddress' => env('CRAFT_TEST_EMAIL'),
    'useCompressedJs' => false,
    'siteUrl' => $scheme . '://' . env('CRAFT_SITEURL'),
];

return $config;
