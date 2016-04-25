<?php

/**
 * General Configuration
 *
 * This is an example configuration file provided by Padstone that demonstrates
 * per environment configuration.
 * You can see a list of the default settings in craft/app/etc/config/defaults/general.php
 */

$env = preg_replace('#^.*/#', '', dirname(CRAFT_BASE_PATH));

if (strpos(CRAFT_BASE_PATH, '/vagrant/') === 0) {
    $env = 'dev';
}

$config = [
	'generateTransformsBeforePageLoad' => true,
	'maxUploadFileSize' => 104857600,
	'omitScriptNameInUrls' => true,
];

switch ($env) {
	case 'dev':
		$config = array_merge($config, [
			'siteUrl' => "http://dev.example.com",
			'devMode' => true,
			'testToEmailAddress' => 'test+example.com@imarc.com',
			'useCompressedJs' => false,
			'cache' => false,
		]);
		break;
	case 'stage':
		$config = array_merge($config, [
			'siteUrl' => 'http://stage.example.com',
			'useCompressedJs' => false,
			'cache' => true,
		]);
		break;
	case 'prod':
		$config = array_merge($config, [
			'siteUrl' => 'https://example.com',
			'cache' => true,
		]);
		break;
	default:
		die("Unfortunately, the server is misconfigured. Please review the configuration in config/general.php.");
}

return $config;
