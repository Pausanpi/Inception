#! /bin/bash

if [ -f ./wp-config.php ]
then
	echo "Wordpress already exists"
else
	wp core download --allow-root
	wp config create --dbname=$MARIA_DATABASE --dbuser=$MARIA_USER --dbpass=$MARIA_PASS --dbhost=mariadb --allow-root
	wp core install --url=$DOMINIO_NAME --title="PausanchPage" --admin_user=pausanch_wordpress --admin_password=1234  --admin_email=pausanch@student.42malaga.com --skip-email --allow-root
	wp user create pausanch pausanpi1606@gmail.com --role=author --user_pass=1234 --allow-root
	wp theme install twentysixteen --activate --allow-root
fi

/usr/sbin/php-fpm7.4 -F;
