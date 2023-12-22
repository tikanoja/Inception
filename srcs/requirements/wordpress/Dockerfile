FROM alpine:3.18

# Create user nginx and add to primary and secondary group nginx (create if it doesn't exist)
RUN addgroup -S nginx && \
	adduser -S -G nginx -g nginx nginx

RUN apk update && \
	apk add --no-cache \
	php81 \
	php81-fpm \
	php81-cgi \
	php81-phar \
	php81-json \
	php81-mysqli \
	php81-curl \
	php81-iconv \
	curl \
	wget \
	composer \
	bash \
	mariadb-client

# Listening port
EXPOSE 9000

# Create and copy paths and confs to cont
RUN mkdir -p /run/php/ /var/www/html/wordpress/

COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY ./tools/wp-setup.sh /
RUN chmod +x wp-setup.sh

ENTRYPOINT ["sh", "/wp-setup.sh"]
