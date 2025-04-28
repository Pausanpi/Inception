#!/bin/bash

# Download and extract WordRress
wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
tar -xzf /tmp/wordpress.tar.gz -C /var/www/html

# Set up Wordpress configuration
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

# Esperar a que MariaDB esté listo
while ! mysqladmin ping -h"mariadb" -u"$MARIA_USER" -p"$MARIA_PASS" --silent; do
    sleep 1
done

# Configuración básica de WordPress
if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    wp config create --dbname=$MARIA_DATABASE --dbuser=$MARIA_USER --dbpass=$MARIA_PASS --dbhost=mariadb --allow-root
    wp core install --allow-root --url=$DOMINIO_NAME --title="Inception" --admin_user=pausanch --admin_password=1234 --admin_email=pausanch@student.42malaga.com --skip-email --path=/var/www/html/wordpress
	wp user create --allow-root $NEW_USER_WP $NEW_EMAIL_WP --user_pass=$NEW_PASS_WP --path=/var/www/html --url=${DOMINIO_NAME}
fi

# Crear usuario solo si no existe
if ! wp user get $NEW_USER_WP --field=login --allow-root 2>/dev/null; then
    wp user create $NEW_USER_WP $NEW_EMAIL_WP --role=author --user_pass=$NEW_PASS_WP --allow-root
fi

# Configuración de temas
wp theme install pixl --allow-root || true
wp theme activate pixl --allow-root

/usr/sbin/php-fpm7.4 -F