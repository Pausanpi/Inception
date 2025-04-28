FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y nginx openssl

EXPOSE 443

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/nginx.sh /var/www

RUN chmod +x /var/www/nginx.sh

ENTRYPOINT [ "/var/www/nginx.sh" ]

CMD ["nginx", "-g", "daemon off;"]