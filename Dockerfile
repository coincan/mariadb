FROM coincan/coinos:3.8
MAINTAINER CoinCan <inputx@goodays.com>

LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="MariaDB on alpine" \
    org.label-schema.description="alpine3.8, mariadb10" \
    org.label-schema.vendor="CoinCan (inputx@goodays.com)" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20181228"

ENV TIMEZONE Australia/Melbourne
ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABASE local
ENV MYSQL_USER user
ENV MYSQL_PASSWORD password


# Copy of the MySQL startup script
COPY scripts /scripts

# Installing packages MariaDB
RUN apk add --no-cache mysql && \
	addgroup mysql mysql && \
	rm -rf /var/cache/apk/* && \
	mkdir /docker-entrypoint-initdb.d && \
    	mkdir /scripts/pre-exec.d && \
    	mkdir /scripts/pre-init.d && \
    	chmod -R 755 /scripts

# Creating the persistent volume
VOLUME [ "/var/lib/mysql" ]

EXPOSE 3306

# ref https://bitbucket.org/yobasystems/alpine-mariadb/src

ENTRYPOINT [ "/scripts/run.sh" ]