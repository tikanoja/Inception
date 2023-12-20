#!/bin/sh

# Create path for logs (add if statement for only to do if not?)
mkdir -p /var/log/mysql
chown -R mysql:mysql /var/log/mysql

# Create path for runtime storage (add if statement for only to do if not?)
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Start if statement from here?
chown -R mysql:mysql /var/lib/mysql

# Initializing database
mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm
echo Database initialized.

# Run SQL setup script
/usr/bin/mysqld --bootstrap --user=mysql < db-setup.sql
echo Database configured.

# Start up MariaDB
echo Starting MariaDB!
mysqld_safe
