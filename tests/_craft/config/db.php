<?php

return [
    'driver' => $_ENV['DB_DRIVER'],
    'server' => $_ENV['DB_SERVER'],
    'user' => $_ENV['DB_USER'],
    'password' => $_ENV['DB_PASSWORD'],
    'database' => $_ENV['TEST_DB_DATABASE'] ?? ($_ENV['DB_DATABASE'] . '_ci'),
    'schema' => $_ENV['DB_SCHEMA'],
    'tablePrefix' => $_ENV['DB_TABLE_PREFIX'],
    'port' => $_ENV['DB_PORT'],
];
