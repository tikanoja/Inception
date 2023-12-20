FROM alpine:3.18.5

# Create user www-data and add to primary and secondary group www-data (create if it doesn't exist)
RUN addgroup -S nginx && \
	adduser -S -G nginx -g nginx nginx

RUN apk update && \
	apk add --no-cache \
	php \
	php-fpm \
	php-cgi \
	php-phar \
	php-json \
	php-mysqli \
	php-curl \
	curl \
	wget \
	composer \
	bash

EXPOSE 9000

RUN mkdir -p /run/php/ /var/www/html/wordpress/

COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY ./tools/wp-setup.sh /
RUN chmod +x wp-setup.sh
ENTRYPOINT ["sh", "/wp-setup.sh"]
