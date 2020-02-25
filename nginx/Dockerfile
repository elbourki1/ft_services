FROM nginx:alpine

RUN apk update && apk add openssl && apk add openssh 

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=MR/ST=37/L=BG/O=1337/CN=EL BOURKI' -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt && apk add openrc
COPY srcs/nginx.conf etc/nginx/nginx.conf
COPY srcs/run.sh /
COPY srcs/sshd_config /etc/ssh/sshd_config
COPY srcs/index.html /usr/share/nginx/html/index.html
EXPOSE 443 80 22
CMD ["sh" , "run.sh"]