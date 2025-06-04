FROM alpine:3.14

RUN apk update && apk add --no-cache mariadb mariadb-client

# Configure MariaDB
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql

# Create setup script
RUN echo '#!/bin/sh \n\
if [ ! -d "/var/lib/mysql/mysql" ]; then \n\
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null \n\
    /usr/bin/mysqld --user=mysql --bootstrap << EOF \n\
USE mysql; \n\
FLUSH PRIVILEGES; \n\
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}; \n\
CREATE USER "${MYSQL_USER}"@"%" IDENTIFIED BY "${MYSQL_PASSWORD}"; \n\
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO "${MYSQL_USER}"@"%"; \n\
ALTER USER "root"@"localhost" IDENTIFIED BY "${MYSQL_ROOT_PASSWORD}"; \n\
FLUSH PRIVILEGES; \n\
EOF\n\
fi \n\
exec /usr/bin/mysqld --user=mysql --console' > /setup.sh && chmod +x /setup.sh

EXPOSE 3306

CMD ["/setup.sh"]
