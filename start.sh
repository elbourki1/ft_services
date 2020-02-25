# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: oel-bour <oel-bour@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 21:44:10 by oel-bour          #+#    #+#              #
#    Updated: 2020/02/25 22:37:42 by oel-bour         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo "deleting minikube"
minikube delete

sleep 2

echo "redeleting minikube and starting it"
minikube start --cpus=2 --memory 2000 --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000

sleep 10
export MINIKUBE_IP=$(minikube ip)

eval $(minikube docker-env)

sleep 2
cp ftps/srcs/start.sh ftps/srcs/start-tmp.sh
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ftps/srcs/start-tmp.sh
cp wordpress/files/wordpress.sql wordpress/files/wordpress-tmp.sql
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" wordpress/files/wordpress-tmp.sql
sleep 2
echo "building images"
echo "building wordpress_alpine"
docker build -t wordpress_alpine wordpress/
sleep 2
echo "building mysql_alpine"
docker build -t mysql_alpine mysql/
sleep 2
echo "building nginx_alpine "
docker build -t nginx_alpine nginx/
sleep 2
echo "building ftps_alpine "
docker build -t ftps_alpine ftps/
sleep 2
echo "building influxdb_alpine "
docker build -t influxdb_alpine influxdb/
sleep 2
echo "building grafana_alpine "
docker build -t grafana_alpine grafana/

echo "deploying"
kubectl apply -f wordpress.yaml
kubectl apply -f mysql.yaml
kubectl apply -f phpmyadmin.yaml
kubectl apply -f nginx.yaml
kubectl apply -f ftps.yaml
kubectl apply -f ingress.yaml > /dev/null
kubectl apply -f influxdb.yaml
kubectl apply -f grafana.yaml
# kubectl apply -f telegraf.yaml

echo "creating database"
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql -u root -e 'CREATE DATABASE wordpress;'
echo "importing database"
sleep 30
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < wordpress/files/wordpress-tmp.sql

rm -rf wordpress/files/wordpress-tmp.sql
rm -rf ftps/srcs/start-tmp.sh

echo "minikube ip is $MINIKUBE_IP"
