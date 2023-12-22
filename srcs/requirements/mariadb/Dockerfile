FROM alpine:3.18

RUN apk update && \
	apk add --no-cache \
	mariadb \
	mariadb-client

EXPOSE 3306

COPY conf/my-mariadb-conf.cnf /etc/my.cnf.d/my-mariadb-conf.cnf
RUN chmod 644 /etc/my.cnf.d/my-mariadb-conf.cnf

COPY ./tools/mariadb-setup.sh /tmp/mariadb-setup.sh
RUN chmod +x /tmp/mariadb-setup.sh

ENTRYPOINT ["sh", "/tmp/mariadb-setup.sh"]
