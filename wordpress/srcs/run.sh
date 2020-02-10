sed -i "s/define('DB_NAME',null);/define('DB_NAME',$(WORDPRESS_DB_NAME));" /var/www/localhosts/htdocs/wp-config.php
sed -i "s/define('DB_USER',null);/define('DB_USER',$(WORDPRESS_DB_USER));" /var/www/localhosts/htdocs/wp-config.php
sed -i "s/define('DB_PASSWORD',null);/define('DB_PASSWORD',$(WORDPRESS_DB_PASSWORD));" /var/www/localhosts/htdocs/wp-config.php
sed -i "s/define('DB_HOST',null);/define('DB_HOST',$(WORDPRESS_DB_HOST));" /var/www/localhosts/htdocs/wp-config.php
exec httpd -DFOREGROUND