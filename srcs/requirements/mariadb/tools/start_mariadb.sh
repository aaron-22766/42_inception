#!/bin/sh
rc-service mariadb start;
mariadb -u root < /tmp/mariadb.sql;
rc-service mariadb stop;
mariadbd -u root;