#!/bin/sh

# Env variables used in script
echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"
echo "WORDPRESS_DB_NAME: $WORDPRESS_DB_NAME"
echo "WORDPRESS_DB_USER: $WORDPRESS_DB_USER"
echo "WORDPRESS_DB_PASSWORD: $WORDPRESS_DB_PASSWORD"

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	
	chown -R mysql:mysql /var/lib/mysql

	# init database
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	/usr/bin/mysqld --user=mysql --bootstrap < /tmp/db-setup.sql
	# rm -f $tfile
fi

exec /usr/bin/mysqld --defaults-file=/etc/my.cnf.d/my-mariadb-conf.cnf --console

# #!/bin/sh

# # Create path for logs (add if statement for only to do if not?)
# mkdir -p /var/log/mysql
# chown -R mysql:mysql /var/log/mysql

# # Create path for runtime storage (add if statement for only to do if not?)
# mkdir -p /run/mysqld
# chown -R mysql:mysql /run/mysqld

# # Start if statement from here?
# chown -R mysql:mysql /var/lib/mysql

# # Initializing database
# mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm
# echo Database initialized.

# # Run SQL setup script
# mysqld --bootstrap --datadir=/var/lib/mysql --user=mysql < /db-setup.sql
# echo Database configured.

# # Start up MariaDB
# echo Starting MariaDB!
# mysqld_safe
