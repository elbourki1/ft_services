FROM alpine:3.7

ENV INFLUXDB_VERSION 1.5.3
ENV TELEGRAF_VERSION 1.6.3

RUN apk add --no-cache su-exec

WORKDIR /scripts

ADD https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz ./
RUN addgroup influxdb && \
        adduser -s /bin/false -G influxdb -S -D influxdb

COPY ./srcs/start.sh start.sh

RUN tar -C . -xzf influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz && \
        chmod +x influxdb-*/* && \
        cp -a influxdb-*/* /usr/bin/ && \
        rm -rf *.tar.gz* influxdb-*/


ADD https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz ./

RUN tar -C . -xzf telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz && \
        chmod +x telegraf/* && \
        cp telegraf/telegraf /usr/bin/ && \
        rm -rf *.tar.gz* telegraf/ 

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY srcs/influxdb.conf /etc/influxdb/influxdb.conf
VOLUME [ "/var/lib/influxdb" ]

EXPOSE 8086

ENTRYPOINT [ "./start.sh" ]