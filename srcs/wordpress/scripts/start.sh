#!/bin/sh
echo "Updating HTTPD config"
sed -i "s/define('DB_NAME', null);/define('DB_NAME', '${WORDPRESS_DB_NAME}');/" /var/www/wp-config.php
sed -i "s/define('DB_USER', null);/define('DB_USER', '${WORDPRESS_DB_USER}');/" /var/www/wp-config.php
sed -i "s/define('DB_PASSWORD', null);/define('DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}');/" /var/www/wp-config.php
sed -i "s/define('DB_HOST', null);/define('DB_HOST', '${WORDPRESS_DB_HOST}');/" /var/www/wp-config.php

echo "Starting all process ..."

php -S "0.0.0.0:5050" -t /var/www/