#!/bin/bash

service ajenti start
until ajenti-ipc v apply; do
    echo Ajenti is not ready, retrying in 10 seconds...
    sleep 10
done
tail -f /var/log/nginx/*