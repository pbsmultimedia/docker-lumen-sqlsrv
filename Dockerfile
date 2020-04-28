FROM php:7.4-apache

RUN apt-get update && \
	apt-get install -y \
	libmcrypt-dev \
	zip \
	nano \
	gnupg2 \
	libxml2-dev

# Microsoft SQL Server Prerequisites
# from: https://laravel-news.com/install-microsoft-sql-drivers-php-7-docker

ENV ACCEPT_EULA=Y

RUN apt-get update \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/9/prod.list \
        > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get install -y --no-install-recommends \
        locales \
        apt-transport-https \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        unixodbc-dev \
        msodbcsql17

RUN pecl install sqlsrv pdo_sqlsrv

RUN docker-php-ext-install soap

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ONBUILD RUN echo "TO-DO: on build run composer install.."

#VOLUME src:/var/www/html/
# volume must be passed thru command line, like:
# -v ${PWD}/src:/var/www/html

COPY config/php.ini	/usr/local/etc/php/php.ini
COPY config/apache2.conf /etc/apache2/apache2.conf
COPY config/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite

EXPOSE 80

#ENTRYPOINT ["/bin/bash"]
ENTRYPOINT service apache2 start && bash
