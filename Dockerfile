FROM php:7.0-fpm-alpine3.4

ENV PACKAGES="nginx py-pip supervisor libmcrypt-dev zlib-dev git"

RUN apk update \
    && apk --no-cache --progress add $PACKAGES \
    && mkdir -p /run/nginx/ \
    && chmod ugo+w /run/nginx/ \
    && rm -f /etc/nginx/nginx.conf \
    && mkdir -p /etc/nginx/conf.d \
    && chmod -R 775 /var/www/ \
    && chown -R nginx:nginx /var/www/ \
    && pip install --upgrade pip \
    && pip install supervisor-stdout \
    && rm /usr/local/etc/php-fpm.d/zz-docker.conf \
    && docker-php-ext-install zip pdo_mysql \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/bin/composer \
    && chmod +x /usr/bin/composer \
    && composer global require hirak/prestissimo


COPY ./manifest/ /

EXPOSE 80

CMD ["/bin/sh", "/entrypoint.sh"]
