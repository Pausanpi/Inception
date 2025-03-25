FROM debian:bullseye

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y mariadb-server
RUN mkdir -p /run/mysqld

EXPOSE 3306

COPY ./tools/mariadb.sh ./mariadb.sh
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d

RUN chmod +x mariadb.sh

CMD ["sh", "mariadb.sh"]