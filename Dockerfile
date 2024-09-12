# Use the official Ubuntu 20.04 image
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    git \
    apache2 \
    php \
    libapache2-mod-php7.4  \ 
    php7.4-mbstring \ 
    php7.4-xmlrpc \ 
    php7.4-gd \ 
    php7.4-xml \ 
    php7.4-intl \ 
    php7.4-mysql \ 
    php7.4-cli \ 
    php7.4-zip \ 
    php7.4-curl \ 
    php7.4-posix \ 
    php7.4-dev  \ 
    php7.4-redis  \ 
    php7.4-gmagick \ 
    php7.4-gmp \
    && apt-get clean

# Optionalish dependencies for feautures
RUN apt install -y ghostscript \
    libgraphicsmagick1-dev \
    libpoppler-dev \
    poppler-utils \
    dcraw \
    redis-server \
    ffmpeg \
    libimage-exiftool-perl \
    libreoffice \
    mediainfo

# Enable Apache mods and install Composer
RUN a2enmod rewrite &&  \
    curl -sS https://getcomposer.org/installer | php &&  \
    mv composer.phar /usr/local/bin/composer

###### Install CollectiveAccess
WORKDIR /var/www/html
RUN git clone https://github.com/collectiveaccess/providence ca
RUN rm -f ./ca/setup.php
COPY setup.php ./ca

# Set permissions for required directories
WORKDIR /var/www/html/ca
RUN chown -R www-data app/tmp app/log media vendor &&  \
    chmod -R 775 app/tmp app/log media vendor

###### Install pawtucket
WORKDIR /var/www/html
RUN git clone https://github.com/collectiveaccess/pawtucket2 pawtucket
RUN rm -f ./pawtucket/setup.php
COPY setup.php ./pawtucket

# Set permissions for required directories
WORKDIR /var/www/html/pawtucket
RUN chown -R www-data:www-data app/tmp vendor app/log && \
    chmod -R 775 app/tmp vendor app/log

# Create symbolic link for media
RUN ln -s /var/www/html/ca/media /var/www/html/pawtucket/media

# This iamge requires a valid server name (hostname), supress warning by
# setting servername as localhost as workaround
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN service apache2 restart

# Expose the web server on port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]

