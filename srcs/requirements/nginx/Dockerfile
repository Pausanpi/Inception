# Use Debian Bullseye as base image
FROM debian:bullseye

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install nginx and OpenSSL in a single layer to reduce image size
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nginx \
        openssl \
        curl \
        netcat \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Create necessary directories
RUN mkdir -p /etc/ssl/private /etc/ssl/certs /var/www/html /var/log/nginx /var/lib/nginx \
    && chown -R www-data:www-data /var/www/html \
    && chmod 755 /var/www/html

# Copy configuration files
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/nginx_start.sh /var/www/nginx_start.sh

# Set proper permissions for the setup script
RUN chmod +x /var/www/nginx_start.sh

# Expose HTTPS port (HTTP port 80 is also handled in nginx.conf)
EXPOSE 443 80

# Use the setup script as entrypoint
ENTRYPOINT ["/var/www/nginx_start.sh"]

# Default command to run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]