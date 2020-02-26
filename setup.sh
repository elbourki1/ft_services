# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: oel-bour <oel-bour@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 21:44:10 by oel-bour          #+#    #+#              #
#    Updated: 2020/02/26 22:25:01 by oel-bour         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo "deleting minikube"
minikube delete

sleep 2

echo "redeleting minikube and starting it"
minikube start --cpus=2 --memory 2000 --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000
# minikube addons enable metrics-server
minikube addons enable ingress
minikube addons enable dashboard
sleep 10
export MINIKUBE_IP=$(minikube ip)

eval $(minikube docker-env)

sleep 2
cp srcs/ftps/srcs/start.sh srcs/ftps/srcs/start-tmp.sh
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/ftps/srcs/start-tmp.sh
cp srcs/wordpress/files/wordpress.sql srcs/wordpress/files/wordpress-tmp.sql
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/wordpress/files/wordpress-tmp.sql
# cp srcs/wordpress/files/word_4.sql srcs/wordpress/files/word_4-tmp.sql
# sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/wordpress/files/word_4-tmp.sql
sleep 2
echo "building images"
echo "building wordpress_alpine"
docker build -t wordpress_alpine srcs/wordpress/
sleep 2
echo "building mysql_alpine"
docker build -t mysql_alpine srcs/mysql/
sleep 2
echo "building nginx_alpine "
docker build -t nginx_alpine srcs/nginx/
sleep 2
echo "building ftps_alpine "
docker build -t ftps_alpine srcs/ftps/
sleep 2
echo "building influxdb_alpine "
docker build -t influxdb_alpine srcs/influxdb/
sleep 2
echo "building grafana_alpine "
docker build -t grafana_alpine srcs/grafana/
# docker build -t phpmyadmin_alpine srcs/phpmyadmin-s/
echo "deploying"
kubectl apply -f srcs/mandatory.yaml
kubectl apply -f srcs/wordpress.yaml
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/phpmyadmin.yaml
kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/ftps.yaml
kubectl apply -f srcs/ingress.yaml
kubectl apply -f srcs/influxdb.yaml
kubectl apply -f srcs/grafana.yaml

sleep 60
echo "creating database"
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql -u root -e 'CREATE DATABASE wordpress;'
echo "importing database"
sleep 5
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < srcs/wordpress/files/wordpress-tmp.sql

rm -rf srcs/wordpress/files/wordpress-tmp.sql
rm -rf srcs/ftps/srcs/start-tmp.sh

echo "minikube ip is $MINIKUBE_IP"
### Crash Container
# kubectl exec -it $(kubectl get pods | grep mysql | cut -d" " -f1) -- /bin/sh -c "kill 1"

### Export/Import Files from containers
# kubectl cp srcs/grafana/grafana.db default/$(kubectl get pods | grep grafana | cut -d" " -f1):/var/lib/grafana/grafana.db
