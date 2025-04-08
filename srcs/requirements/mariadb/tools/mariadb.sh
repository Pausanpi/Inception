#!/bin/bash

# Modificar la configuración de MariaDB para aceptar conexiones remotas
sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Iniciar directamente mysqld_safe para crear bases de datos
if [ ! -d "/var/lib/mysql/$MARIA_DATABASE" ]; then
    echo "Iniciando MariaDB temporalmente..."
    mysqld_safe --skip-networking &
    
    # Esperar a que MariaDB esté listo
    until mysqladmin ping -h localhost --silent; do
        echo "Esperando a que MariaDB esté disponible..."
        sleep 2
    done
    
    echo "Creando base de datos y usuario..."
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS $MARIA_DATABASE;
CREATE USER IF NOT EXISTS '$MARIA_USER'@'%' IDENTIFIED BY '$MARIA_PASS';
GRANT ALL PRIVILEGES ON $MARIA_DATABASE.* TO '$MARIA_USER'@'%';
FLUSH PRIVILEGES;
EOF
    
    echo "Cerrando MariaDB para reiniciarlo con la nueva configuración..."
    mysqladmin -u root shutdown
    
    # Asegurar que el proceso de mysqld_safe termine completamente
    while pgrep -f mysqld > /dev/null; do
        echo "Esperando a que MariaDB se cierre..."
        sleep 1
    done
fi

echo "Iniciando MariaDB con la configuración actualizada..."
exec mysqld_safe
