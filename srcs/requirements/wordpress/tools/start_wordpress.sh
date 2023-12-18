#!/bin/sh

if [ ! -f /var/www/html/wp-config.php ]; then
    while ! wp config create --allow-root \
                            --url=$DOMAIN_NAME \
                            --dbname=$DB_NAME \
                            --dbuser=$DB_USER \
                            --dbpass=$DB_USER_PWD \
                            --dbhost=mariadb:3306 \
                            --force 2> /dev/null
    do
        echo 1>&2 "Waiting for MariaDB to be ready..."
        sleep 1
    done

    wp core install --allow-root \
                    --url=$DOMAIN_NAME \
                    --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PWD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --skip-email

    wp user create $WP_USER $WP_USER_EMAIL \
                --allow-root \
                --role=author \
                --user_pass=$WP_USER_PWD

    wp option update home $DOMAIN_NAME
    wp option update siteurl $DOMAIN_NAME
fi

php-fpm81 -F