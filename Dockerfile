FROM php:7.2-fpm-alpine3.6

ENV PACKAGES="nginx py-pip supervisor"

RUN apk update && \
    apk --no-cache --progress add $PACKAGES && \
    mkdir -p /run/nginx/ && \
    chmod ugo+w /run/nginx/ && \
    rm -f /etc/nginx/nginx.conf && \
    mkdir -p /etc/nginx/conf.d && \
    chmod -R 775 /var/www/ && \
    chown -R nginx:nginx /var/www/ && \
    pip install --upgrade pip && \
    pip install supervisor-stdout && \
    rm /usr/local/etc/php-fpm.d/zz-docker.conf


COPY ./manifest/ /

VOLUME ["/var/www/app"]

EXPOSE 80

CMD ["/bin/sh", "/entrypoint.sh"]
