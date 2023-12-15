FROM alpine:3.18.5

RUN apk update \
 && apk --no-cache add mariadb mariadb-client openrc \
 && openrc \
 && touch /run/openrc/softlevel

COPY ./conf/my.cnf /etc/my.cnf.d/my.cnf

RUN /etc/init.d/mariadb setup

COPY ./tools/start_mariadb.sh /tmp/start_mariadb.sh

RUN chmod +x /tmp/start_mariadb.sh

ENTRYPOINT ["/tmp/start_mariadb.sh"]