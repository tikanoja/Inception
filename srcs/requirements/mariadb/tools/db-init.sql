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
