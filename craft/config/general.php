<?php

/**
 * General Configuration
 *
 * This is an example configuration file provided by Padstone that demonstrates
 * per environment configuration.
 * You can see a list of the default settings in craft/app/etc/config/defaults/general.php
 */

$scheme = 'http';
if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') {
    $scheme = 'https';
}

$config = [
    'omitScriptNameInUrls' => true,
    'maxUploadFileSize' => 104857600,
    'devMode' => env('CRAFT_DEVMODE', false),
    'testToEmailAddress' => 'test@imarc.com',
    'useCompressedJs' => false,
    'siteUrl' => $scheme . '://' . env('CRAFT_SITEURL'),
];

return $config;
