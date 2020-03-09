FROM alpine:latest

ENV OUTPUT_FILE_NAME=/phpmyadmin.tar.xz \
    PHP_MYADMIN_VERSION="5.0.1" \
    PMA_SECRET="" \
        PMA_DB="phpmyadmin" \
    PMA_DB="phpmyadmin" \
    PMA_USERNAME="root" \
    PMA_PASSWORD="password" \
    MYSQL_HOSTNAME="mysql"
RUN apk upgrade && \
    apk --update add \
      php7 php7-mbstring php7-session php7-bcmath php7-cli php7-ctype php7-curl php7-fpm php7-gd php7-json php7-mcrypt php7-mysqli \
      php7-opcache  php7-openssl php7-pdo php7-pdo_mysql php7-phar php7-xml php7-zip php7-zlib ca-certificates \
      nginx mysql-client \
      curl xz sed \
      && \
    curl -L http://files.phpmyadmin.net/phpMyAdmin/${PHP_MYADMIN_VERSION}/phpMyAdmin-${PHP_MYADMIN_VERSION}-all-languages.tar.xz -o ${OUTPUT_FILE_NAME} && \
    tar -xJpf /phpmyadmin.tar.xz && \
    rm -rf /phpmyadmin.tar.xz && \
    mkdir -p /www/  && \
    mv /phpMyAdmin-${PHP_MYADMIN_VERSION}-all-languages/ /www/phpmyadmin && \
    chown -R nginx: /www/phpmyadmin && \
     apk del \
          curl xz sed && \
      rm -rf /tmp/src && \
      rm -rf /var/cache/apk/*
EXPOSE 5000
COPY srcs/config.inc.php /www/phpmyadmin/config.inc.php
COPY srcs/run.sh /bin/run.sh
ENTRYPOINT [ "sh", "/bin/run.sh" ]