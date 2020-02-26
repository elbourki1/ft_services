## Golang build container
# FROM golang:1.13.4-alpine // base image of grafana/grafana
FROM grafana/grafana

# COPY srcs/datasources.yml /etc/grafana/provisioning/datasources/
# COPY srcs/dashboard.yml /etc/grafana/provisioning/dashboards/
# COPY srcs/*.json /etc/grafana/provisioning/dashboards/
# FROM  alpine:latest
COPY srcs/grafana.db /var/lib/grafana/grafana.db

ENTRYPOINT [ "/run.sh" ]
