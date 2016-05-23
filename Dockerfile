FROM debian:latest
MAINTAINER Eugene Min <e.min@milax.com>

RUN apt-get update
RUN apt-get install -y apt-utils nano wget curl nginx nginx php5-fpm memcached php5-memcached php5-cli php5-mcrypt php5-curl php5-mysql php5-sqlite php5-pgsql
RUN wget https://nodejs.org/download/release/v4.4.4/node-v4.4.4-linux-x64.tar.gz && tar -C /usr/local --strip-components 1 -xzf node-v4.4.4-linux-x64.tar.gz
RUN ls -l /usr/local/bin/node
RUN ls -l /usr/local/bin/npm
RUN npm i -g npm
RUN npm i -g gulp-cli
RUN echo user = 1000 >> /etc/php5/fpm/pool.d/www.conf
RUN echo group = staff >> /etc/php5/fpm/pool.d/www.conf
RUN wget https://getcomposer.org/download/1.1.1/composer.phar && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
RUN wget https://phar.phpunit.de/phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit && chmod +x /usr/local/bin/phpunit
COPY ./serve.sh /usr/bin/serve
RUN chmod +x /usr/bin/serve
ENV DEBIAN_FRONTEND noninteractive
EXPOSE 80 443
WORKDIR /var/www