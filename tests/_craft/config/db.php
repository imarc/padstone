<?php
//run from commandline to test connection: php -r "new PDO('mysql:host=mariadb;dbname=your_db_name;port=3306', 'root', '');"

return [
    'dsn' => getenv('DB_DSN'),
    'user' => getenv('DB_USER'),
    'password' => getenv('DB_PASSWORD'),
    'schema' => getenv('DB_SCHEMA'),
    'tablePrefix' => getenv('DB_TABLE_PREFIX'),
];