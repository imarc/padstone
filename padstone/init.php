<?php
// Initialize environment variables

try {
    $dotenv = new Dotenv\Dotenv(dirname(__DIR__));
    $dotenv->load();
} catch (Exception $e) {}

