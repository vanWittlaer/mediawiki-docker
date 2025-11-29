FROM serversideup/php:8.2-fpm-apache

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

# Install system dependencies
RUN docker-php-serversideup-dep-install-debian ffmpeg \
    && docker-php-serversideup-dep-install-debian imagemagick \
    && docker-php-serversideup-dep-install-debian nano \
    && docker-php-serversideup-dep-install-debian default-mysql-client

USER www-data
