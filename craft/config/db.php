<?php

/**
 * DB Configuration
 *
 * This is an example configuration file provided by Padstone that demonstrates
 * per environment configuration.
 * You can see a list of the default settings in craft/app/etc/config/defaults/db.php
 */

$config = [
    'server' => env('DB_HOST'),
    'user' => env('DB_USER'),
    'database' => env('DB_NAME'),
    'password' => env('DB_PASSWORD'),
    'tablePrefix' => env('DB_TABLE_PREFIX', ''),
];

return $config;
