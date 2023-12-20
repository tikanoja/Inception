FROM alpine:3.13

# Create user www-data and add to primary and secondary group www-data (create if it doesn't exist)
RUN addgroup -S nginx && \
	adduser -S -G nginx -g nginx nginx

RUN apk update && \
	apk add --no-cache --quiet --update \
	php7 \
	php-fpm \
	php-cgi \
	php-phar \
	php-json \
	php-mysqli \
	php-curl \
	php-iconv \
	curl \
	wget \
	composer \
	bash \
	mariadb-client

EXPOSE 9000

RUN mkdir -p /run/php/ /var/www/html/wordpress/

COPY conf/www.conf /etc/php7/php-fpm.d/www.conf

COPY ./tools/wp-setup.sh /
RUN chmod +x wp-setup.sh

ENTRYPOINT ["sh", "/wp-setup.sh"]
