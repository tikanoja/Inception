#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	
	chown -R mysql:mysql /var/lib/mysql

	# init database
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
		return 1
	fi

	# https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw
	cat << EOF > $tfile
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
	/usr/bin/mysqld --user=mysql --bootstrap < $tfile
	# rm -f $tfile
fi

sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec /usr/bin/mysqld --user=mysql --console

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
