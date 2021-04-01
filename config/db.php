<?php
/**
 * Database Configuration
 *
 * All of your system's database connection settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/DbConfig.php.
 */

return [
    'driver' => $_ENV['DB_DRIVER'],
    'server' => $_ENV['DB_SERVER'],
    'user' => $_ENV['DB_USER'],
    'password' => $_ENV['DB_PASSWORD'],
    'database' => $_ENV['DB_DATABASE'],
    'schema' => $_ENV['DB_SCHEMA'],
    'tablePrefix' => $_ENV['DB_TABLE_PREFIX'],
    'port' => $_ENV['DB_PORT']
];
