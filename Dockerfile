FROM debian:latest
MAINTAINER Eugene Min <e.min@milax.com>

RUN apt-get update -y
RUN apt-get install -y \
    sudo \
    nano \
    wget \
    curl \
    nginx \
    php5-fpm \
    php5-memcached \
    php5-cli \
    php5-mcrypt \
    php5-curl \
    php5-mysql \
    php5-sqlite \
    php5-pgsql \
    php5-xdebug

RUN echo xdebug.max_nesting_level=500 >> /etc/php5/mods-available/xdebug.ini

RUN wget https://nodejs.org/download/release/v4.4.4/node-v4.4.4-linux-x64.tar.gz && tar -C /usr/local --strip-components 1 -xzf node-v4.4.4-linux-x64.tar.gz
RUN ls -l /usr/local/bin/node
RUN ls -l /usr/local/bin/npm
RUN npm i -g npm
RUN npm i -g gulp-cli

RUN echo "www-data ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN wget https://getcomposer.org/download/1.1.1/composer.phar && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
RUN wget https://phar.phpunit.de/phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit && chmod +x /usr/local/bin/phpunit

COPY ./cp /root/cp
RUN php5dismod xdebug && cd /root/cp && composer install --no-interaction && php5enmod xdebug
RUN cd /root/cp && npm install
RUN cd /root/cp && gulp coffee

COPY ./scripts/default /root/default
COPY ./scripts/serve.sh /usr/bin/serve
RUN chmod +x /usr/bin/serve

ENV DEBIAN_FRONTEND noninteractive
EXPOSE 80 443

WORKDIR /var/www

CMD chown -R www-data:www-data /root \
    && chmod -R 755 /root \
    && cp /root/default /etc/nginx/sites-available/default \
    && service nginx restart \
    && service php5-fpm restart \
    && tail -F /var/log/nginx/*