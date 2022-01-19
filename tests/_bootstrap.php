<?php

use craft\test\TestSetup;

ini_set('date.timezone', 'UTC');

// Set CRAFT_ENVIRONMENT to a value we can use to recognize this as tests.
define('CRAFT_ENVIRONMENT', 'tests');

// Path to the tests folder.
define('CRAFT_TESTS_PATH', __DIR__);

// Storage for tests is /tests/_craft/storage, separate from your local dev environment.
define('CRAFT_STORAGE_PATH', __DIR__ . '/_craft/storage');

// Use a separate tests/_craft/config folder for configuration.
define('CRAFT_CONFIG_PATH', __DIR__ . '/_craft/config');

// The following constants are the same for both local development and testing.
define('CRAFT_BASE_PATH', dirname(__DIR__));
define('CRAFT_MIGRATIONS_PATH', dirname(__DIR__) . '/migrations');
define('CRAFT_TEMPLATES_PATH', dirname(__DIR__) . '/templates');
define('CRAFT_TRANSLATIONS_PATH', dirname(__DIR__) . '/translations');
define('CRAFT_VENDOR_PATH', dirname(__DIR__).'/vendor');

TestSetup::configureCraft();
