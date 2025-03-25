FROM debian:bullseye

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y nginx openssl

COPY ./tools/nginx.sh ./nginx.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

RUN chmod +x nginx.sh

CMD ["./nginx.sh"]