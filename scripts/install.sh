#!/bin/bash

set -e

echo "Waiting for MariaDB to respond..."

while ! nc -z db 3306; do
    sleep 1
done

echo "MariaDB ready!"

export CRAFT_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)

sudo -E -u www-data php /var/www/vendor/bin/schematic import

echo "------------------------------------------------------------------------------------"
echo "Success! Your craft credentials are admin/$CRAFT_PASSWORD. Change the password ASAP."
echo "------------------------------------------------------------------------------------"
