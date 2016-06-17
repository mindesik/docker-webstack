#!/bin/bash

sed -i 's/sendfile on/sendfile off/g' /etc/nginx/nginx.conf
service ajenti start
until ajenti-ipc v apply; do
    echo Ajenti is not ready, retrying in 10 seconds...
    sleep 10
done
tail -f /var/log/nginx/*