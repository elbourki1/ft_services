adduser otman -D
echo "otman:123456" | chpasswd
supervisord  -c /etc/supervisord.conf