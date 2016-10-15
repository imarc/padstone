<?php

/**
 * DB Configuration
 *
 * This is an example configuration file provided by Padstone that demonstrates
 * per environment configuration.
 * You can see a list of the default settings in craft/app/etc/config/defaults/db.php
 */

$config = [
    'server' => env('DB_HOST', 'db'),
    'user' => env('DB_USER', 'craft'),
    'database' => env('DB_NAME', 'craft'),
    'password' => env('DB_PASSWORD', 'craft'),
    'tablePrefix' => env('DB_TABLE_PREFIX', ''),
];

return $config;
