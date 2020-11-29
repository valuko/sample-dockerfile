FROM php:7.1.20-apache

RUN apt-get -y update --fix-missing
RUN apt-get upgrade -y

# Install useful tools
RUN apt-get -y install apt-utils nano wget dialog

# Install important libraries
RUN apt-get -y install --fix-missing apt-utils build-essential git curl libcurl3 libcurl3-dev zip libmcrypt-dev mysql-client libicu-dev zlib1g-dev

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install xdebug
RUN pecl install xdebug-2.5.0
# RUN docker-php-ext-enable mysqli pdo pdo_mysql xdebug curl tokenizer json zip mbstring
RUN docker-php-ext-install pdo_mysql 
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install zip

# Enable apache modules
RUN a2enmod rewrite headers ssl

COPY www/ /var/www/html/
COPY config/php/php.ini /usr/local/etc/php/
COPY config/php/vhosts/ /etc/apache2/sites-enabled/

RUN curl -o ioncube.tar.gz http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar -xvzf ioncube.tar.gz \
    && mv ioncube/ioncube_loader_lin_7.1.so `php-config --extension-dir` \
    && rm -Rf ioncube.tar.gz ioncube \
    && docker-php-ext-enable ioncube_loader_lin_7.1