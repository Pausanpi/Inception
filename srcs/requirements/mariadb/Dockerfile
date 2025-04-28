FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Ensure MariaDB directories exist with proper permissions
RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql && \
    chmod 777 /run/mysqld
	
COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf

# Create your custom directory for the script
RUN mkdir -p /var/www/initdb

# Copy the setup script into the container
COPY ./tools/mariadb.sh /var/www/initdb/mariadb.sh

# Make the script executable
RUN chmod +x /var/www/initdb/mariadb.sh

EXPOSE 3306

# The script will handle user switching as needed
ENTRYPOINT ["/var/www/initdb/mariadb.sh"]