#!/bin/sh

# Wait for MariaDB to be ready
attempts=0
while ! mariadb -h$MYSQL_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME &>/dev/null; do
	attempts=$((attempts + 1))
    echo "MariaDB unavailable. Attempt $attempts: Trying again in 5 sec."
	if [ $attempts -ge 12 ]; then
		echo "Max attempts reached. MariaDB connection could not be established."
        exit 1
	fi
    sleep 5
done
echo "MariaDB connection established!"

echo "Listing databases:"
mariadb -h$MYSQL_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME <<EOF
SHOW DATABASES;
EOF

# Set working dir
cd /var/www/html/wordpress/

# Download WP cli
wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp

# Make it executable
chmod +x /usr/local/bin/wp

# DL WP using the CLI
wp core download --allow-root

# Transfer ownership to the user
# chown -R nginx:nginx /var/www/html/wordpress

# # Full permissions for owner, read/exec to others
# chmod -R 755 /var/www/html/wordpress

# Create WordPress database config
wp config create \
	--dbname=$WORDPRESS_DB_NAME \
	--dbuser=$WORDPRESS_DB_USER \
	--dbpass=$WORDPRESS_DB_PASSWORD \
	--dbhost=$MYSQL_HOST \
	--path=/var/www/html/wordpress/ \
	--force

# Install WordPress and feed db config
# ADD /wordpress to URL IF NOT GOOD!!!!!
wp core install \
	--url=$DOMAIN_NAME \
	--title=$WORDPRESS_TITLE \
	--admin_user=$WORDPRESS_ADMIN_USER \
	--admin_password=$WORDPRESS_ADMIN_PASSWORD \
	--admin_email=$WORDPRESS_ADMIN_EMAIL \
	--allow-root \
	--skip-email \
	--path=/var/www/html/wordpress/

# Create WordPress user
wp user create \
	$WORDPRESS_USER \
	$WORDPRESS_EMAIL \
	--role=author \
	--user_pass=$WORDPRESS_PASSWORD \
	--allow-root

# Install theme for WordPress
wp theme install inspiro \
	--activate \
	--allow-root

# Update plugins
wp plugin update --all

# Update WP address and site address to match our domain
wp option update siteurl "https://$DOMAIN_NAME" --allow-root
wp option update home "https://$DOMAIN_NAME" --allow-root

# Example setting permissions for the theme directory
# chown -R nginx:nginx /var/www/html/wordpress/wp-content/themes/inspiro/
# chmod -R 755 /var/www/html/wordpress/wp-content/themes/inspiro/

# Transfer ownership to the user
chown -R nginx:nginx /var/www/html/wordpress

# Full permissions for owner, read/exec to others
chmod -R 755 /var/www/html/wordpress

# Fire up PHP-FPM (-F to keep in foreground and avoid recalling script)
php-fpm81 -F
