FROM grafana/grafana

COPY srcs/datasources.yml /etc/grafana/provisioning/datasources/
COPY srcs/dashboard.yml /etc/grafana/provisioning/dashboards/
COPY srcs/*.json /etc/grafana/provisioning/dashboards/

ENTRYPOINT [ "/run.sh" ]
