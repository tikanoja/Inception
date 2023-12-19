-- db_setup.sql

-- Specify db to tweak
USE mysql;

-- Reload priviledge tables
FLUSH PRIVILEGES;

-- Enforce root w our defined password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- Create new database that will handle Unicode
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create a new user
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Give full priviledges to the user we just created
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

-- You already know
FLUSH PRIVILEGES;
