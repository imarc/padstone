<?php
// load env() helper method
Env::init();

// Initialize environment variables
try {
    $dotenv = new Dotenv\Dotenv(dirname(__DIR__));

    $dotenv->load();

    $dotenv->required(
        'DB_HOST',
        'DB_USER',
        'DB_NAME',
        'CRAFT_SITEURL',
        'CRAFT_SITENAME'
    )->notEmpty();
} catch (Exception $e) {
    die($e->getMessage());
}


