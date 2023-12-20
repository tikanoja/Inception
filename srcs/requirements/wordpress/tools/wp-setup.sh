#!/bin/sh

# Env variables used in script
echo "MYSQL_HOST:               $MYSQL_HOST"
echo "MYSQL_ROOT_PASSWORD:      $MYSQL_ROOT_PASSWORD"
echo "WORDPRESS_DB_NAME:        $WORDPRESS_DB_NAME"
echo "WORDPRESS_DB_USER:        $WORDPRESS_DB_USER"
echo "WORDPRESS_DB_PASSWORD:    $WORDPRESS_DB_PASSWORD"
echo "DOMAIN_NAME:              $DOMAIN_NAME"
echo "WORDPRESS_TITLE:          $WORDPRESS_TITLE"
echo "WORDPRESS_ADMIN_USER:     $WORDPRESS_ADMIN_USER"
echo "WORDPRESS_ADMIN_PASSWORD: $WORDPRESS_ADMIN_PASSWORD"
echo "WORDPRESS_ADMIN_EMAIL:    $WORDPRESS_ADMIN_EMAIL"
echo "WORDPRESS_USER:           $WORDPRESS_USER"
echo "WORDPRESS_EMAIL:          $WORDPRESS_EMAIL"
echo "WORDPRESS_PASSWORD:       $WORDPRESS_PASSWORD"

# trying out sleeping
while ! mariadb -h$MYSQL_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME &>/dev/null; do
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

# Transfer ownership recursively to the user
chown -R nginx:nginx /var/www/html/wordpress

# Full permissions for owner, read/exec to others
chmod -R 755 /var/www/html/wordpress

# Create WordPress config
wp config create \
	--dbname=$WORDPRESS_DB_NAME \
	--dbuser=$WORDPRESS_DB_USER \
	--dbpass=$WORDPRESS_DB_PASSWORD \
	--dbhost=$MYSQL_HOST \
	--path=/var/www/html/wordpress/ \
	--force #experimental forcing here so check logs...

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
php-fpm7 -nodaemonize
