FROM alpine:3.18.5

RUN apk update \
 && apk add mariadb-client \
            php81 \
            php81-common \
            php81-curl \
            php81-dom \
            php81-exif \
            php81-fileinfo \
            php81-fpm \
            php81-intl \
            php81-json \
            php81-mbstring \
            php81-mysqli \
            php81-openssl \
            php81-pecl-igbinary \
            php81-phar \
            php81-xml \
            php81-zip

WORKDIR /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 && chmod +x wp-cli.phar \
 && mv wp-cli.phar /usr/local/bin/wp \
 && wp core download --allow-root

COPY ./tools/start_wordpress.sh /tmp/start_wordpress.sh

RUN chmod +x /tmp/start_wordpress.sh

ENTRYPOINT ["/tmp/start_wordpress.sh"]