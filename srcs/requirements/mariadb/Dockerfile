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

#there was an error of not being able to create log file, check 'docker logs mariadb-cont' if gone now
RUN mkdir -p /var/log/mysql/
RUN chmod -R /var/log/mysql/
# COPY ./tools/db-setup.sql /
# RUN chmod 644 db-setup.sql

ENTRYPOINT ["sh", "/tmp/mariadb-setup.sh"]
