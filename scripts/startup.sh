#!/bin/bash

service ajenti start
until ajenti-ipc v apply; do
    echo Ajenti is not ready, retrying in 5 seconds...
    sleep 5
done
sed -i 's/sendfile on/sendfile off/g' /etc/nginx/nginx.conf
service nginx restart
tail -f /var/log/nginx/*