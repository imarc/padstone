<?php

/**
 * General Configuration
 *
 * This is an example configuration file provided by Padstone that demonstrates
 * per environment configuration.
 * You can see a list of the default settings in craft/app/etc/config/defaults/general.php
 */

$config = [
    'omitScriptNameInUrls' => true,
    'maxUploadFileSize' => 104857600,
    'devMode' => true,
    'testToEmailAddress' => 'test+vestmark.com@imarc.com',
    'useCompressedJs' => false,
    'siteUrl' => $_SERVER['HTTPS'] ? 'https://' : 'http://'
];

return $config;
