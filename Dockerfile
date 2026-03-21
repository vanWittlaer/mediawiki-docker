FROM serversideup/php:8.3-fpm-apache

LABEL org.opencontainers.image.source="https://github.com/vanWittlaer/mediawiki-base"
LABEL org.opencontainers.image.description="Base MediaWiki image with PHP extensions and dependencies"

USER root

# Install PHP extensions required for MediaWiki
RUN install-php-extensions apcu \
    bcmath \
    calendar \
    gd \
    imagick \
    intl \
    memcached \
    sockets \
    wikidiff2

# Enable OPcache (serversideup controls it via env vars)
ENV PHP_OPCACHE_ENABLE=1 \
    PHP_OPCACHE_MEMORY_CONSUMPTION=256 \
    PHP_OPCACHE_MAX_ACCELERATED_FILES=20000 \
    PHP_OPCACHE_INTERNED_STRINGS_BUFFER=16 \
    PHP_OPCACHE_VALIDATE_TIMESTAMPS=0

# Install system dependencies
RUN docker-php-serversideup-dep-install-debian ffmpeg \
    && docker-php-serversideup-dep-install-debian ghostscript \
    && docker-php-serversideup-dep-install-debian imagemagick \
    && docker-php-serversideup-dep-install-debian nano \
    && docker-php-serversideup-dep-install-debian poppler-utils \
    && docker-php-serversideup-dep-install-debian rclone

USER www-data
