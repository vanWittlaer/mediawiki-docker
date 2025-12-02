# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a base Docker image for MediaWiki, built on top of `serversideup/php:8.2-fpm-apache`. The image pre-installs PHP extensions and system dependencies required to run MediaWiki. It is published to GitHub Container Registry (ghcr.io).

## Build Commands

Build the Docker image locally:
```bash
docker build -t mediawiki-base .
```

Multi-platform build (matching CI):
```bash
docker buildx build --platform linux/amd64,linux/arm64 -t mediawiki-base .
```

## Architecture

- **Dockerfile**: Single-stage build that installs PHP extensions (apcu, bcmath, gd, imagick, intl, memcached, mysqli, wikidiff2, etc.) and system dependencies (ffmpeg, imagemagick, nano, mysqldump)
- **GitHub Actions**: Automated build and push to ghcr.io on pushes to main branch or version tags (v*)

## Key Details

- Base image uses `install-php-extensions` for PHP extension installation
- System packages installed via `docker-php-serversideup-dep-install-debian`
- mysqldump copied from mysql:8.0.40-debian image for database backup capability
- Container runs as `www-data` user
