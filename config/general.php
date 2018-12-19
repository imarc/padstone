<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 */

return [
    // Global settings
    '*' => [
        // Base site URL
        'siteUrl' => getenv('CRAFT_SITEURL'),

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
        'securityKey' => getenv('SECURITY_KEY'),
       
        // Overload the default CP asset source paths (/web/cperesources).
        'resourceBasePath' => '@webroot/writable/cpresources',
        'resourceBaseUrl'  => '@web/writable/cpresources',
    ],

    // Environment specific settings
    'dev' => [
        'devMode' => true, // Dev Mode (see https://craftcms.com/support/dev-mode)
        'cacheElementQueries'   => false,
        'testToEmailAddress' => 'test@imarc.com',
    ],

    // Staging environment settings
    'staging' => [
        'devMode' => false, // Dev Mode (see https://craftcms.com/support/dev-mode)
        'cacheElementQueries'   => true,
    ],

    // Production environment settings
    'production' => [
        'devMode' => false, // Dev Mode (see https://craftcms.com/support/dev-mode)
        'cacheElementQueries'   => true,
    ],
];
