FROM alpine:latest
RUN apk update && apk add mysql-client && addgroup mysql mysql && \
rm -rf /var/cache/apk

COPY srcs/run.sh /bin/run.sh
COPY srcs/my.cnf etc/mysql/my.cnf
VOLUME ["/var/lib/mysql"]
EXPOSE 3306
ENTRYPOINT ["/bin/run.sh"]