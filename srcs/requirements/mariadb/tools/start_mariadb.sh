#!/bin/sh
echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_USER_PWD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PWD}';
FLUSH PRIVILEGES;
EXIT;" > /tmp/setup_database.sql

rc-service mariadb start;
mariadb -u root < /tmp/setup_database.sql;
rc-service mariadb stop;
exec mariadbd -u root;