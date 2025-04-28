#!/bin/sh

# Wait for MariaDB (improved security)
echo "Waiting for MariaDB..."
sleep 5

# Install WordPress if not present
if [ ! -f wp-config.php ]; then
    echo "Installing WordPress..."
    wp core download --allow-root
    wp config create \
        --dbname=$MARIA_DATABASE \
        --dbuser=$MARIA_USER \
        --dbpass=$MARIA_PASS \
        --dbhost=$MARIA_HOSTNAME \
        --allow-root
    wp core install \
        --url="https://$DOMINIO_NAME" \
        --title="Inception" \
        --admin_user="$LOGIN" \
        --admin_password="$USER_WP" \
        --admin_email="$ADMIN_EMAIL_WP" \
        --skip-email \
        --allow-root

    # Create additional regular user
    wp user create "$NEW_USER_WP" "$NEW_EMAIL_WP" \
        --user_pass="$NEW_PASS_WP" \
        --role=author \
        --allow-root

    wp theme install twentytwentyfour --activate --allow-root
    echo "WordPress installed successfully!"
else
    echo "WordPress already installed."
fi

# Update site URL using environment variable instead of hardcoded value
wp option update home "https://$DOMINIO_NAME" --allow-root
wp option update siteurl "https://$DOMINIO_NAME" --allow-root

# Ensure proper permissions
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec php-fpm7.4 -F