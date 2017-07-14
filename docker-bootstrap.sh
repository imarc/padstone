#!/bin/bash
set -e

# create craft storage volume dirs
echo "Creating craft storage volume dirs"

mkdir -p /var/www/craft/storage/runtime/{cache,compiled_templates,logs,state}
chown -R www-data:www-data /var/www/craft/storage
chmod -R 775 /var/www/craft/storage

mkdir -p /var/www/public/writable/images
chown -R www-data:www-data /var/www/public/writable
chmod -R 775 /var/www/public/writable

# if initialized don't run schematic
if [ -f /var/www/craft/storage/padstone.lock ]
then
    exit
fi

echo "Waiting for MariaDB to respond..."

while ! nc -z db 3306; do
	sleep 1
done

echo "MariaDB ready!"

export CRAFT_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)

php /var/www/vendor/bin/schematic import

echo "---------------------------------------------------------------------------"
echo "Your Craft credentials are admin/$CRAFT_PASSWORD". Change the password ASAP.
echo "---------------------------------------------------------------------------"

touch /var/www/craft/storage/padstone.lock
