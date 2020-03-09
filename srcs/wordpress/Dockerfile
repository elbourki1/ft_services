FROM alpine:latest

ENV VERSION_WORDPRESS 4.9.6
ENV SERVER_PATH /var/www

# Installing dependencies
RUN apk add --no-cache --virtual .build-deps unzip
RUN apk add --no-cache php7 php7-apache2 php7-openssl php7-xml php7-pdo php7-mcrypt php7-session php7-mysqli php7-zlib su-exec
# Work path
WORKDIR /var/www/

# Download & install wordpress
ADD https://wordpress.org/wordpress-${VERSION_WORDPRESS}.zip ./
RUN unzip -q wordpress-${VERSION_WORDPRESS}.zip -d ./ && \
        mv /var/www/wordpress/* ./ && \
        rm -rf /var/www/wordpress && \
        rm /var/www/wordpress-${VERSION_WORDPRESS}.zip \
            ${SERVER_PATH}/wp-config-sample.php \
            ${SERVER_PATH}/license.txt \
            ${SERVER_PATH}/readme.html && \
        apk del .build-deps

COPY scripts/start.sh /bin/start.sh
COPY files/wp-config.php ${SERVER_PATH}/wp-config.php

EXPOSE 5050

ENTRYPOINT [ "sh","/bin/start.sh" ]