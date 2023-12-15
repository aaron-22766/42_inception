#!/bin/sh

sed -i "s/listen = 127.0.0.1:9000/listen = 9000/g" /etc/php81/php-fpm.d/www.conf

while ! nc -z mariadb 3306; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

wp config create --allow-root \
                 --url="${DOMAIN_NAME}" \
                 --dbname="${DB_NAME}" \
                 --dbuser="${DB_USER}" \
                 --dbpass="${DB_USER_PWD}" \
                 --dbhost="mariadb:3306" \
                 --force

wp core install --allow-root \
                --url="${DOMAIN_NAME}" \
                --title="${WP_TITLE}" \
                --admin_user="${WP_ADMIN_USER}" \
                --admin_password="${WP_ADMIN_PWD}" \
                --admin_email="${WP_ADMIN_EMAIL}" \
                --skip-email

wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
               --allow-root \
               --role=author \
               --user_pass="${WP_USER_PWD}"

wp option update home "${DOMAIN_NAME}"
wp option update siteurl "${DOMAIN_NAME}"

php-fpm81 -F