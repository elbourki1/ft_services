FROM alpine
RUN mkdir /run/nginx/ 
RUN apk update && apk add openrc openssl openssh nginx supervisor \
&& ssh-keygen -A
RUN apk update
COPY srcs/default.conf /etc/nginx/conf.d
COPY srcs/run.sh /
RUN  echo "<h1>Hello Word!</h1>" > /var/www/localhost/htdocs/index.html
COPY srcs/supervisord.conf /etc/
EXPOSE 443 80 22
ENTRYPOINT ["sh" , "run.sh"]