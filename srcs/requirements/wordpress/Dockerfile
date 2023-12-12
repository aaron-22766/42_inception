FROM alpine:3.18.5

RUN apk update \
 && apk --no-cache add php7.3 php-fpm php-mysql mariadb-client

COPY ./conf/wordpress.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./tools/start_wordpress.sh /tmp/start_wordpress.sh

RUN chmod +x /tmp/start_wordpress.sh

ENTRYPOINT ["/tmp/start_wordpress.sh"]