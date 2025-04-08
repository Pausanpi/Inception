#!/bin/bash
mkdir -p /etc/nginx/ssl
if [ ! -f /etc/nginx/ssl/nginx-selfsigned.crt ]; then
    echo "Nginx: setting up ssl ...";
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt -subj "/C=ES/ST=Malaga/L=Malaga/O=wordpress/CN=pausanch.42.fr";
    echo "Nginx: ssl is set up!";
fi
exec "$@"