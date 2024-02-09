# Dockerfile for ProjeQtOr application

# Base image with PHP and Apache web server
FROM php:8.0-apache

ARG PJT_VERSION=11.1.3
ARG PJT_ARCHIVE_NAME=projeqtorV${PJT_VERSION}.zip
ARG PJT_EXTRACT_DIR=projeqtor
ARG PJT_ARCHIVE_URL=https://freefr.dl.sourceforge.net/project/projectorria/projeqtorV${PJT_VERSION}.zip

# Set PHP configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
    sed -i -e 's/max_input_vars = 1000/max_input_vars = 4000/' \
           -e 's/;request_terminate_timeout = 0/request_terminate_timeout = 0/' \
           -e 's/max_execution_time = 30/max_execution_time = 120/' \
           -e 's/memory_limit = 128M/memory_limit = 512M/' \
           -e 's/;file_uploads = On/file_uploads = On/' \
           -e 's/;error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/' \
           "$PHP_INI_DIR/php.ini"

RUN echo "max_input_vars = 4000" >> "$PHP_INI_DIR/php.ini"

# Install necessary PHP extensions
RUN apt-get update && \
    apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        libonig-dev \
        libpq-dev \
        libxml2-dev \
        unzip \
        wget \
        && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd mbstring pdo pdo_pgsql pgsql xml zip

RUN echo "Downloading ProjeQtOr" \
    && wget -q -O /tmp/${PJT_ARCHIVE_NAME} ${PJT_ARCHIVE_URL} \
    && echo "Extracting ProjeQtOr archive" \
    && unzip -q /tmp/${PJT_ARCHIVE_NAME} -d /tmp \
    # Assuming the archive extracts to a single directory /tmp/${PJT_EXTRACT_DIR}
    && mv /tmp/${PJT_EXTRACT_DIR}/* /var/www/html/ \
    # Cleanup
    && rm -rf /tmp/${PJT_ARCHIVE_NAME} /tmp/${PJT_EXTRACT_DIR}

# Copy parameters
COPY ./config/parametersLocation.php /var/www/html/tool/parametersLocation.php
RUN ls /var/www/html/
RUN mkdir -p /opt/projeqtor
RUN mv /var/www/html/files /opt/projeqtor/
COPY ./config/parameters.php /opt/projeqtor/files/config/parameters.php

# Update permissions for /opt/projeqtor
RUN mkdir -p /opt/projeqtor/files/logs && \
    chown -R www-data:www-data /opt/projeqtor && \
    chmod -R 755 /opt/projeqtor

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
