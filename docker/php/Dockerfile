FROM php:8.3.15-apache

# Expose Vite development server port
EXPOSE 5173

# ==========================================
# System Package Installation
# ==========================================
RUN apt update && apt install -y \
    zlib1g-dev \
    g++ \
    libicu-dev \
    zip \
    libzip-dev \
    libpq-dev \
    git \
    sudo \
    && a2enmod rewrite

# ==========================================
# PHP Extensions Installation
# ==========================================
RUN docker-php-ext-install \
    intl \
    opcache \
    pdo \
    pgsql \
    pdo_pgsql \
    pdo_mysql \
    bcmath \
    && pecl install mailparse \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip

# ==========================================
# GD and EXIF Extensions
# ==========================================
RUN apt update && apt install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd exif

# ==========================================
# Node.js Installation
# ==========================================
RUN apt update && apt install -y nodejs npm \
    && npm install n -g \
    && n --latest

# ==========================================
# Composer Installation
# ==========================================
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin

# ==========================================
# Laravel Installer
# ==========================================
RUN composer global require "laravel/installer"

# ==========================================
# User Setup
# ==========================================
RUN useradd -m -s /bin/bash dev \
    && usermod -aG sudo dev \
    && echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# ==========================================
# Git Configuration
# ==========================================
# Create .ssh directory for dev user (will be overridden by volume mount)
RUN mkdir -p /home/dev/.ssh \
    && chown -R dev:dev /home/dev/.ssh \
    && chmod 700 /home/dev/.ssh

# Ensure proper permissions for shared credentials
RUN chown -R dev:dev /home/dev

# ==========================================
# Working Directory Setup
# ==========================================
WORKDIR /var/www/html

# fix permission for mounted volumes and start apache
RUN echo '#!/bin/bash\n\
sudo chown -R dev:dev /var/www/html\n\
\n\
apache2-foreground' > /usr/local/bin/start.sh \
    && chmod +x /usr/local/bin/start.sh

# Set the startup script as the default command
CMD ["/usr/local/bin/start.sh"]