FROM alpine:latest
ENV  TIME_ZONE=africa/morroco
ENV WORDPRESS_VERSION=4.9.6
ENV APACHE_SERVER=/var/www/localhost/htdocs
RUN apk add --no-cach --virtual .build_deps
RUN apk add --no-cach apache2 php7 php7-apache2 php7-openssl php7-xml php7-pdo php7-mcrypt php7-session php7-mysqli php7-zlib
RUN mkdir -p /run/apache2/run/httpd
ADD https://wordpress.org/wordpress-${WORDPRESS_VERSION}.zip ./
RUN unzip -q wordpress-${WORDPRESS_VERSION}.zip && rm -rf ${APACHE_SERVER} && mv wordpress ${APACHE_SERVER} && rm -rf wordpress-${WORDPRESS_VERSION}.zip \
&& rm $APACHE_SERVER/wp-config-sample.php && rm $APACHE_SERVER/readme.html &&rm $APACHE_SERVER/license.txt && chown -R apache:apache ${APACHE_SERVER}
EXPOSE 80
CMD ["rc-update ","add", "apache2"]