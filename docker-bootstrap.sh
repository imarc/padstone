#!/bin/bash
set -e

#chown -R docker:www-data
#chmod -R 775 craft

# if initialized don't run schematic
if [ -f /tmp/initialized ]
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

touch /tmp/initialized
