#!/bin/sh
echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_USER_PWD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PWD}';
FLUSH PRIVILEGES;
EXIT;" > /tmp/setup_database.sql

mkdir -p /run/mysqld
mkdir -p /var/lib/mysql

mysql_install_db --user=mysql --datadir=/var/lib/mysql

exec mariadbd --no-defaults --user=root --datadir=/var/lib/mysql --init-file=/tmp/setup_database.sql