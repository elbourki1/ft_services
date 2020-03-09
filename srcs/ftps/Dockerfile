FROM alpine:latest

RUN apk upgrade && \
    printf '%s\n' \
      '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' \
      >> /etc/apk/repositories && \
    apk update && \
    apk add pure-ftpd@testing="1.0.49-r0" && apk add openssl \
    rm -rf /var/cache/apk/*
WORKDIR /etc/ssl/private/
RUN openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -subj '/C=MR/ST=37/L=BG/O=1337/CN=EL BOURKI' -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem
COPY srcs/start-tmp.sh /bin/start-tmp.sh

EXPOSE 21 21000-21010
VOLUME [ "/ftps" ]
ENTRYPOINT ["sh","/bin/start-tmp.sh"]