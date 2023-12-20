FROM alpine:3.18

# Create user nginx and add to primary and secondary group nginx (create if it doesn't exist)
RUN addgroup -S nginx && \
	adduser -S -G nginx -g nginx nginx

RUN apk update && \
	apk add --no-cache \
	php82 \
	php82-fpm \
	php82-cgi \
	php82-phar \
	php82-json \
	php82-mysqli \
	php82-curl \
	php82-iconv \
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
