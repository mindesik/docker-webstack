FROM debian:8.6
MAINTAINER Eugene Min <e.min@milax.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y \
    sudo \
    nano \
    wget \
    curl \
    openssh-client

RUN apt-get update -y
RUN apt-get install -y nginx php5-fpm php5-memcached php5-mcrypt php5-gd php5-sqlite php5-pgsql php5-xdebug php5-json php5-mysqlnd

RUN echo "www-data ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN wget https://getcomposer.org/download/1.2.4/composer.phar && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
RUN wget https://phar.phpunit.de/phpunit-library-5.3.5.phar && mv phpunit-library-5.3.5.phar /usr/local/bin/phpunit && chmod +x /usr/local/bin/phpunit

WORKDIR /srv

RUN apt-get install -y php5-curl

RUN apt-get install -y git
RUN wget https://nodejs.org/download/release/v4.6.0/node-v4.6.0-linux-x64.tar.gz
RUN tar -C /usr/local --strip-components 1 -xzf node-v4.6.0-linux-x64.tar.gz
RUN npm -g install npm
RUN npm -g install gulp-cli
RUN npm -g install coffee-script
RUN npm -g install bower
RUN php5dismod xdebug

COPY ./scripts/serve.sh /usr/local/bin/serve
RUN chmod +x /usr/local/bin/serve

EXPOSE 80 8000 443
CMD service nginx restart && service php5-fpm restart && tail -f /var/log/nginx/*