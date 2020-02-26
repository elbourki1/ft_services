#!/bin/sh

adduser root
echo "root:password" | chpasswd
influx -execute "CREATE USER root WITH PASSWORD 'root' WITH ALL PRIVILEGES"
influx -execute 'CREATE DATABASE "influxdb"'
chown -R influxdb:influxdb /var/lib/influxdb
exec su-exec influxdb /usr/bin/influxd $@ &
exec /usr/bin/telegraf $@