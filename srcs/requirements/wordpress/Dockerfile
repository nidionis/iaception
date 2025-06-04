FROM alpine:3.14

RUN apk update && apk add --no-cache \
    php7 \
    php7-fpm \
    php7-mysqli \
    php7-json \
    php7-curl \
    php7-dom \
    php7-exif \
    php7-fileinfo \
    php7-mbstring \
    php7-openssl \
    php7-xml \
    php7-zip \
    wget

# Install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configure php-fpm
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php7/php-fpm.d/www.conf

# Create workdir
WORKDIR /var/www/html

# Create setup script
RUN echo '#!/bin/sh \n\
if [ ! -f /var/www/html/wp-config.php ]; then \n\
    wget https://wordpress.org/latest.tar.gz && \n\
    tar -xzf latest.tar.gz --strip-components=1 && \n\
    rm latest.tar.gz && \n\
    wp core config --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=mariadb --allow-root && \n\
    wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --allow-root && \n\
    wp user create ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --role=author --allow-root \n\
fi \n\
php-fpm7 -F' > /setup.sh && chmod +x /setup.sh

EXPOSE 9000

CMD ["/setup.sh"]
