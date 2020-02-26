# adduser -D otman
echo "12345" > pass
echo "12345" >> pass
adduser otman < pass
rc-status
/etc/init.d/sshd start
touch /run/openrc/softlevel
/etc/init.d/sshd start
# echo "otman:123456" | chpasswd
nginx -g 'daemon off;'