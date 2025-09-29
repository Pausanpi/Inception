#!/bin/sh

# Create SSL directories if they don't exist
mkdir -p /etc/ssl/certs /etc/ssl/private

# Generate SSL certificate if it doesn't exist
if [ ! -f /etc/ssl/certs/nginx.crt ]; then
    echo "Nginx: setting up ssl ...";
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
        -keyout /etc/ssl/private/nginx.key \
        -out /etc/ssl/certs/nginx.crt \
        -subj "/C=ES/ST=Malaga/L=Malaga/O=wordpress/CN=pausanch.42.fr";
    echo "Nginx: ssl is set up!";
fi

# Set proper permissions for SSL files
chmod 600 /etc/ssl/private/nginx.key
chmod 644 /etc/ssl/certs/nginx.crt

# Simple wait for WordPress
echo "Waiting for WordPress to be ready..."
sleep 15

# Test if WordPress is responding on port 9000
echo "Testing WordPress connectivity..."
for i in {1..30}; do
    if nc -z wordpress 9000 2>/dev/null; then
        echo "WordPress is responding on port 9000"
        break
    fi
    echo "Waiting for WordPress... ($i/30)"
    sleep 2
done

# Test nginx configuration before starting
echo "Testing nginx configuration..."
if ! nginx -t; then
    echo "Nginx configuration test failed!"
    echo "=== Nginx configuration file ==="
    cat /etc/nginx/nginx.conf
    echo "=== SSL certificate status ==="
    ls -la /etc/ssl/certs/nginx.crt /etc/ssl/private/nginx.key
    echo "=== Directory permissions ==="
    ls -la /var/www/html
    exit 1
fi

echo "Starting nginx..."
exec "$@"