<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 */

return [
    // Disable updates via Control Panel
    'allowUpdates' => false,

    // Default Week Start Day (0 = Sunday, 1 = Monday...)
    'defaultWeekStartDay' => 0,

    // Enable CSRF Protection (recommended, will be enabled by default in Craft 3)
    'enableCsrfProtection' => true,

    // Whether "index.php" should be visible in URLs
    'omitScriptNameInUrls' => true,

    // Control Panel trigger word
    'cpTrigger' => 'admin',

    // The secure key Craft will use for hashing and encrypting data
    'securityKey' => 'kJ7Fhr5Vn8b3gfju8j_py_5b9tEAI9-p',

    // Whether the site should be in dev mode
    'devMode' => true,

    // Use config/project.yaml as the canonical project config
    'useProjectConfigFile' => true,
];
