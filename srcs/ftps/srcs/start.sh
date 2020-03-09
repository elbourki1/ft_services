mkdir -p /ftps/admin
adduser -h /ftps/admin -D admin
echo "admin:admin" | chpasswd
chown -R admin:admin /ftps/admin

/usr/sbin/pure-ftpd -j -Y 2 -p 21000:21010 -P "MINIKUBE_IP"