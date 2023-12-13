FROM alpine:3.18.5

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

# RUN add a user i guess ?

RUN chmod +x /wordpressconfig.sh

RUN mkdir /run/php/

COPY ./tools/wp-setup.sh /

CMD ["./wp-setup.sh"]
