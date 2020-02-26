FROM alpine:latest

RUN apk add --no-cache --virtual .build-deps unzip
RUN apk --no-cache --update add \
      php7 php7-mbstring php7-session php7-bcmath php7-cli php7-ctype php7-curl php7-fpm php7-gd php7-json php7-mcrypt php7-mysqli \
      php7-opcache  php7-openssl php7-pdo php7-pdo_mysql php7-phar php7-xml php7-zip php7-zlib ca-certificates \
      nginx mysql-client
# Work path
WORKDIR /var/www

ADD http://phpmyadmin.net/downloads/phpMyAdmin-latest-english.zip ./
RUN unzip -q phpMyAdmin-latest-english.zip  -d ./ && \
        rm /var/www/phpMyAdmin-latest-english.zip && \
        mv  phpMyAdmin-5.0.1-english/*  ./ && \
        rm -rf /var/www/phpMyAdmin-5.0.1-english && \
        apk del .build-deps
COPY srcs/run.sh /bin/run.sh
ENTRYPOINT [ "sh", "/bin/run.sh" ]