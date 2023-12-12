FROM alpine:3.18.5

RUN apk update \
 && apk --no-cache add nginx openssl \
 && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=DE/ST=BW/L=Heilbronn/O=42/OU=student/CN=arabenst.42.fr/UID=arabenst"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]