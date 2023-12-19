#!/bin/sh

# trying out sleeping
until mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1" &>/dev/null; do
    echo "MariaDB is unavailable - sleeping"
    sleep 3
done

echo "MariaDB connection established!"

# Set working dir
cd /var/www/html/wordpress/

# Download WP cli
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp

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
	--path=/var/www/html/wordpress/

# Install WordPress
wp core install \
	--url=$DOMAIN_NAME/wordpress \
	--title=$WORDPRESS_TITLE \
	--admin_user=$WORDPRESS_ADMIN_USER \
	--admin_password=$WORDPRESS_ADMIN_PASSWORD \
	--admin_email=$WORDPRESS_ADMIN_EMAIL \
	--path=/var/www/html/wordpress/

# Create WordPress user
wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=author --user_pass=$WORDPRESS_PASSWORD

# Install theme for WordPress
wp theme install inspiro --activate

# Update plugins
wp plugin update --all

# Fire up PHP-FPM
php-fpm81 -F
