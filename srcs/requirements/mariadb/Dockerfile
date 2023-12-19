FROM alpine:3.18.5

RUN apk update && \
	apk add --no-cache \
	mariadb \
	mariadb-client

EXPOSE 3306

COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
RUN chmod 644 /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/mariadb-setup.sh /
RUN chmod +x mariadb-setup.sh

COPY ./tools/db-setup.sql /
RUN chmod 644 db-setup.sql

ENTRYPOINT ["sh", "/mariadb-setup.sh"]
