<?php

use craft\helpers\App;

return [
    'useDevServer' => App::env('USE_VITE_DEV_SERVER') ?? false,
    'manifestPath' => '@webroot/dist/.vite/manifest.json',
    'devServerPublic' => 'http://localhost:5173/',
    'serverPublic' => App::env('DEFAULT_SITE_URL') . '/dist/',
    'errorEntry' => '',
    'cacheKeySuffix' => '',
    'devServerInternal' => '',
    'checkDevServer' => false,
    'includeReactRefreshShim' => false,
    'includeModulePreloadShim' => true,
    'criticalPath' => '@webroot/dist/criticalcss',
    'criticalSuffix' =>'_critical.min.css',
];
