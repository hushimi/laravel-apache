FROM php:8.3.15-apache

# VITE用ポート開放
EXPOSE 5173

# Package & Library install
RUN apt update && apt install -y zlib1g-dev g++ libicu-dev zip libzip-dev libpq-dev \
    && docker-php-ext-install intl opcache pdo pgsql pdo_pgsql pdo_mysql \
    && pecl install mailparse \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && docker-php-ext-install bcmath \
    && apt-get install -y git \
    && a2enmod rewrite

# gd, exif
RUN apt update && apt install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd exif

# node
RUN apt update && apt install -y nodejs npm \
    && npm install n -g \
    && n lts

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin

# Laravel Package install
RUN composer global require "laravel/installer"

# WorkDir Path setting
WORKDIR /var/www/html