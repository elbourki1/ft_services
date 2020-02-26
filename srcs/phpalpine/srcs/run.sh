

rc-service lighttpd start && rc-update add lighttpd default

/usr/bin/mysql_install_db --user=mysql
/etc/init.d/mysql start && rc-update add mysql default
/usr/bin/mysqladmin -u root password 'password'
mkdir -p /usr/share/webapps/

cd /usr/share/webapps
wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-4.5.0.2-all-languages.tar.gz
tar zxvf phpMyAdmin-4.5.0.2-all-languages.tar.gz
rm phpMyAdmin-4.5.0.2-all-languages.tar.gz
mv phpMyAdmin-4.5.0.2-all-languages phpmyadmin

chmod -R 777 /usr/share/webapps/

php -S "0.0.0.0:5000" -t /usr/share/webapps/phpmyadmin/