FROM php:8.2-fpm-alpine3.18 as drupalBase

RUN apk update

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN install-php-extensions \
  gd \
  apcu \
  csv \
  opcache \
  pcntl \
  pdo_pgsql \
  pgsql

COPY ./ini/opcache.ini /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
COPY ./ini/error.ini /usr/local/etc/php/conf.d/error.ini
COPY ./ini/override.ini /usr/local/etc/php/conf.d/override.ini

RUN chown -R 644 /usr/local/etc/php/conf.d
