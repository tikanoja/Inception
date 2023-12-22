#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	# Transfer ownership to user
	chown -R mysql:mysql /var/lib/mysql

	# init database
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	# Script to remove masking anon user and create ours (credit to malatinipro on Github)
	# https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw
	initscript=$(mktemp)
	cat << EOF > $initscript
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM	mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE $WORDPRESS_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$WORDPRESS_DB_USER'@'%' IDENTIFIED by '$WORDPRESS_DB_PASSWORD';
GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

cat "$initscript"

	# Feeding the script to bootstrapped mysql server
	/usr/bin/mysqld --user=mysql --bootstrap < $initscript
	# rm &initscript
fi

exec /usr/bin/mysqld --defaults-file=/etc/my.cnf.d/my-mariadb-conf.cnf
