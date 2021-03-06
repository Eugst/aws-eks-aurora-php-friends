FROM composer AS composer

# copying the source directory and install the dependencies with composer
COPY . /app

# run composer install to install the dependencies
RUN composer install \
  --optimize-autoloader \
  --no-interaction \
  --no-progress

# continue stage build with the desired image and copy the source including the
# dependencies downloaded by composer
FROM trafex/alpine-nginx-php7
COPY --chown=nginx --from=composer /app /var/www/html

USER root
RUN apk add --update --no-cache php7-simplexml libcap mysql-client libxml2-dev php7-mysqli php7-pdo php7-pdo_mysql && \
    setcap cap_setgid=ep /bin/busybox && \
    chown -R nobody.nobody /var/www/html
USER nobody
ENV SHELL=/bin/sh
