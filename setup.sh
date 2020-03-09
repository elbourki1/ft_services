# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: oel-bour <oel-bour@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 21:44:10 by oel-bour          #+#    #+#              #
#    Updated: 2020/03/08 20:19:21 by oel-bour         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo "deleting minikube"
minikube delete

sleep 2

echo "redeleting minikube and starting it"
minikube start --cpus=2 --memory 2000 --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000
minikube addons enable ingress
minikube addons enable dashboard
sleep 10
minikube ssh 'mkdir /home/docker/ftps'
export MINIKUBE_IP=$(minikube ip)

eval $(minikube docker-env)

sleep 2
cp srcs/ftps/srcs/start.sh srcs/ftps/srcs/start-tmp.sh
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/ftps/srcs/start-tmp.sh
cp srcs/wordpress/files/wordpress.sql srcs/wordpress/files/wordpress-tmp.sql
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/wordpress/files/wordpress-tmp.sql

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
sleep 2
echo "building phpmyadmin_alpine "
docker build -t phpmyadmin_alpine srcs/phpmyadmin/

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
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql -u root -e 'CREATE DATABASE wordpress;'
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql -u root -e 'CREATE DATABASE phpmyadmin;'
echo "importing database"
sleep 10
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < srcs/wordpress/files/wordpress-tmp.sql
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql phpmyadmin -u root < srcs/phpmyadmin/srcs/phpmyadmin.sql
sleep 5
rm -rf srcs/wordpress/files/wordpress-tmp.sql
rm -rf srcs/ftps/srcs/start-tmp.sh
echo "minikube ip is $MINIKUBE_IP"

### crash Container
# kubectl exec -it $(kubectl get pods | grep mysql | cut -d" " -f1) -- /bin/sh -c "kill 1"
#lftp ftp://admin@$(minikube ip)
### export/Import Files from containers
# kubectl cp  $(kubectl get pods | grep grafana | cut -d" " -f1):/grafana/data/grafana.db grafana.db

