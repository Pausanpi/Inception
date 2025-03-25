echo "CREATE DATABASE IF NOT EXISTS ${MARIA_DATABASE};" >> init.sql
echo "CREATE USER '${MARIA_USER}'@'%' IDENTIFIED BY '${MARIA_PASS}';" >> init.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIA_ROOT_PASS}';" >> init.sql
echo "GRANT ALL PRIVILEGES ON *.* TO '${MARIA_USER}'@'%';" >> init.sql
echo "FLUSH PRIVILEGES;" >> init.sql

chmod 777 init.sql
mv init.sql /run/mysqld/init.sql
chown -R mysql:root /var/run/mysqld

mariadbd --init-file /run/mysqld/init.sql