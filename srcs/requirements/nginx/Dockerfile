FROM debian:bullseye

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y nginx openssl

COPY ./tools/nginx.sh /var/www
COPY ./conf/nginx.conf /etc/nginx/sites-enabled/nginx.conf

EXPOSE 443

RUN chmod +x /var/www/nginx.sh

ENTRYPOINT [ "/var/www/nginx.sh" ]

CMD ["nginx", "-g", "daemon off;"]
