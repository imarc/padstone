#!/bin/bash
set -e

# create craft storage volume dirs
echo "Provisioning craft volumes"

sudo mkdir -p /var/www/craft/storage/runtime/{cache,compiled_templates,logs,state}
sudo chown -R www-data:www-data /var/www/craft/storage
sudo chmod -R 775 /var/www/craft/storage

sudo mkdir -p /var/www/public/writable/images
sudo chown -R www-data:www-data /var/www/public/writable
sudo chmod -R 775 /var/www/public/writable

sudo chown -R www-data:www-data /var/www/public
sudo chown -R www-data:www-data /var/www/craft/config
