<?php

/**
 * DB Configuration
 *
 * This is an example configuration file provided by Padstone that demonstrates
 * per environment configuration.
 * You can see a list of the default settings in craft/app/etc/config/defaults/db.php
 */

$env = preg_replace('#^.*/#', '', dirname(CRAFT_BASE_PATH));

if (strpos(CRAFT_BASE_PATH, '/vagrant/') === 0) {
    $env = 'dev';
}

$config = [
    'server'      => 'localhost',
    'user'        => 'web',
    'tablePrefix' => '',
];

switch ($env) {
	case 'dev':
		$config = array_merge($config, [
            'database' => 'dev_example_com',
		]);
		break;
	case 'stage':
		$config = array_merge($config, [
            'database' => 'stage_example_com',
		]);
		break;
	case 'prod':
		$config = array_merge($config, [
            'database' => 'example_com',
		]);
		break;
	default:
		die("Unfortunately, the server is misconfigured. Please review the configuration in config/db.php.");
}

return $config;
