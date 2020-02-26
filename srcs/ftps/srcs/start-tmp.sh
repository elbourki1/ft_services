#!/bin/sh
mkdir -p /ftps/$FTP_USER
echo "ftps ft-services" > /ftps/admin/test.txt
adduser -h /ftps/$FTP_USER -D $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

# /usr/sbin/pure-ftpd -j -Y 2 -p 21000:21000 -p 21001:21001 -p 21002:21002 -p 21003:21003 -p 21004:21004 \
#                             -p 21005:21005 -p 21006:21006 -p 21007:21007 -p 21008:21009 -p 21010:21010 -P ""
/usr/sbin/pure-ftpd -j -Y 2 -p 21000:21000 -P ""
