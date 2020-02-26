FROM alpine:latest

RUN echo "http://pkg.example.com/alpine/v3.9/community" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache lighttpd php7-common php7-iconv php7-json php7-gd php7-curl \
                        php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo \
                        php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt \
                        php7-gettext php7-ldap php7-ctype php7-dom \
                        mysql mysql-client php-mysql php-mysqli && \
                        
COPY srcs/run.sh /bin/run.sh
ENTRYPOINT [ "sh","/bin/run.sh" ]