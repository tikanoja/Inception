#!/bin/sh

# Set working dir
cd /var/www/html/wordpress/

# Download WP cli
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/win/wp

# Make it executable
chmod +x /usr/local/bin/wp

# Install WP using the CLI
wp core download --allow-root

# Transfer ownership recursively to the www-user
chown -R www-data:www-data /var/www/html/wordpress

# Full permissions for owner, read/exec to others
chmod -R 755 /var/www/html/wordpress

# Create WordPress config
wp config create \
	--dbname=$WORDPRESS_DB_NAME \
	--dbuser=$WORDPRESS_DB_USER \
	--dbpass=$WORDPRESS_DB_PASSWORD \
	--dbhost=$WORDPRESS_DB_HOST \
	--path=/var/www/html/wordpress

# Fire up PHP-FPM
php-fpm81 -F
