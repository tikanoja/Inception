#!/bin/sh

# Create path for logs (add if statement for only to do if not?)
mkdir -p /var/log/mysql
chown -R mysql:mysql /var/log/mysql

# Create path for runtime storage (add if statement for only to do if not?)
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Start if statement from here?
chown -R mysql:mysql /var/lib/mysql

# Initializing database (uncomment > /dev/null for more verbose logs)
mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm #> /dev/null

# Run SQL setup script
mysqld --bootstrap --datadir=/var/lib/mysql --user=mysql < ./db-setup.sql

# Start up MariaDB
mysqld_safe
