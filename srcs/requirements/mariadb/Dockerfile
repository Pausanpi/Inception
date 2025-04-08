FROM debian:bullseye

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y mariadb-server
RUN apt-get install curl -y

RUN apt-get clean && rm -rf var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

EXPOSE 3306

COPY ./tools/mariadb.sh /usr/local/bin
RUN chmod +x /usr/local/bin/mariadb.sh

RUN mysql_install_db

ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]