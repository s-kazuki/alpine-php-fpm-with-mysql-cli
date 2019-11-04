FROM php:7.0-fpm-alpine

LABEL maintainer="S-Kazuki<contact@revoneo.com>"

RUN apk update \
  && apk add tzdata \
  && TZ=${TZ:-Asia/Tokyo} \
  && cp /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ> /etc/timezone \
  && apk del tzdata \
  && rm -rf /var/cache/apk/* \
  \
  && apk add --no-cache bash libzip-dev freetype freetype-dev libjpeg-turbo libjpeg-turbo-dev libpng libpng-dev \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
  && docker-php-ext-install zip mysqli pdo pdo_mysql gd \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer