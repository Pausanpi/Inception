# Use Debian Bullseye as base image
FROM debian:bullseye

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV MYSQL_DATA_DIR=/var/lib/mysql
ENV MYSQL_RUN_DIR=/run/mysqld
ENV MYSQL_LOG_DIR=/var/log/mysql

# Install MariaDB server and client
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        mariadb-server \
        mariadb-client \
        gosu \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Create necessary directories with proper permissions
RUN mkdir -p \
        ${MYSQL_RUN_DIR} \
        ${MYSQL_DATA_DIR} \
        ${MYSQL_LOG_DIR} \
        /var/www/initdb \
    && chown -R mysql:mysql \
        ${MYSQL_RUN_DIR} \
        ${MYSQL_DATA_DIR} \
        ${MYSQL_LOG_DIR} \
    && chmod 755 ${MYSQL_RUN_DIR} ${MYSQL_DATA_DIR} ${MYSQL_LOG_DIR}

# Copy MariaDB configuration
COPY ./conf/my.cnf /etc/mysql/my.cnf

# Copy database setup script
COPY ./tools/db.sh /var/www/initdb/db.sh
RUN chmod +x /var/www/initdb/db.sh

# Expose MariaDB port
EXPOSE 3306

# Use setup script as entrypoint
ENTRYPOINT ["/var/www/initdb/db.sh"]