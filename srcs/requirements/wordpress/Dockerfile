FROM alpine:3.18.5

RUN apk update \
 && apk add mariadb-client \
            php81 \
            php81-fpm \
            php81-openssl \
            php81-mysqli \
            php81-phar \
            php81-curl \
            php81-common \
            php81-exif \
            php81-dom \
            php81-intl \
            php81-pecl-igbinary \
            php81-json \
            php81-fileinfo \
            php81-mbstring \
            php81-zip \
            php81-xml \
            php81-xmlreader

WORKDIR /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 && chmod +x wp-cli.phar \
 && mv wp-cli.phar /usr/local/bin/wp \
 && wp core download --allow-root \
 && adduser -S www-data -G www-data \
 && chown -R www-data:www-data . /var/log/php81 \
 && chmod g+s . /var/log/php81 \
 && chmod 775 . /var/log/php81 \
 && find ./wp-content/plugins/ -mindepth 1 -maxdepth 1 -type d -exec rm -r \
    -- {} \; -or -type f -name "*" ! -name "index.php" -exec rm -- {} \;

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf
COPY ./conf/php.ini /etc/php81/php.ini
COPY ./tools/start_wordpress.sh /tmp/start_wordpress.sh

RUN chmod +x /tmp/start_wordpress.sh

USER www-data

ENTRYPOINT ["/tmp/start_wordpress.sh"]