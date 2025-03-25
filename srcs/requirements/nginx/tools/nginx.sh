#!/bin/sh

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out "$CERTIFICATE" -keyout "$CERT_KEY" -subj "/C=ES/ST=Andalucia/L=Malaga/O=42/OU=42/CN=$DOMINIO_NAME/UID=$LOGIN"

sed -i "s/dominio_name/$DOMINIO_NAME/" /etc/nginx/nginx.conf
sed -i "s#ssl_certificate /etc/nginx/ssl/nginx-selfsigned.crt;#ssl_certificate $CERTIFICATE;#" /etc/nginx/nginx.conf
sed -i "s#ssl_certificate_key /etc/nginx/ssl/nginx-selfsigned.key;#ssl_certificate_key $CERT_KEY;#" /etc/nginx/nginx.conf

nginx -g "daemon off;"