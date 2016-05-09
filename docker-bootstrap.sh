#!/bin/bash
set -e

# if initialized don't run schematic
if [ -f /initialized ]
then
	exit
fi

touch /initialized

echo "Waiting for mysql to start"

while ! nc -z db 3306; do
	sleep 1
done

echo "mysql ready"

export CRAFT_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

php /var/www/vendor/bin/schematic import

echo "--------------------------------------------------------"
echo "Your Craft password is: $CRAFT_PASSWORD"
echo "--------------------------------------------------------"
