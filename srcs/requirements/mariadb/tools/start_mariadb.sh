#!/bin/sh
sed -i "s/\${DB_NAME}/$DB_NAME/g"  /tmp/mariadb.sql;
sed -i "s/\${DB_USER}/$DB_USER/g"  /tmp/mariadb.sql;
sed -i "s/\${DB_PW}/$DB_PW/g"  /tmp/mariadb.sql;
sed -i "s/\${DB_ROOT_PW}/$DB_ROOT_PW/g"  /tmp/mariadb.sql

rc-service mariadb start;
mariadb -u root < /tmp/mariadb.sql;
rc-service mariadb stop;
exec mariadbd -u root;