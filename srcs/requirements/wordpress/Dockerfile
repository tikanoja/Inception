FROM alpine:3.18

# Create user nginx and add to primary and secondary group nginx (create if it doesn't exist)
RUN addgroup -S nginx && \
	adduser -S -G nginx -g nginx nginx

RUN apk update && \
	apk add --no-cache \
	php8.2 \
	php8.2-fpm \
	php8.2-cgi \
	php8.2-phar \
	php8.2-json \
	php8.2-mysqli \
	php8.2-curl \
	php8.2-iconv \
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
