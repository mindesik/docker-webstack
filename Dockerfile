FROM ubuntu:16.04
MAINTAINER Eugene Min <e.min@milax.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y sudo nano wget curl openssh-client zip

RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update -y
RUN apt-get install -y nginx php5.6-fpm php5.6-mbstring php5.6-memcached php5.6-mcrypt php5.6-gd php5.6-sqlite php5.6-xdebug php5.6-json php5.6-mysqlnd php5.6-curl php5.6-xml

RUN echo "www-data ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm composer-setup.php
RUN wget https://phar.phpunit.de/phpunit-library-5.3.5.phar && mv phpunit-library-5.3.5.phar /usr/local/bin/phpunit && chmod +x /usr/local/bin/phpunit

WORKDIR /srv

RUN apt-get install -y git
RUN wget https://nodejs.org/download/release/v4.6.0/node-v4.6.0-linux-x64.tar.gz
RUN tar -C /usr/local --strip-components 1 -xzf node-v4.6.0-linux-x64.tar.gz
RUN npm -g install npm
RUN npm -g install gulp-cli
RUN npm -g install coffee-script
RUN npm -g install bower
RUN phpdismod xdebug

COPY ./scripts/serve.sh /usr/local/bin/serve
RUN chmod +x /usr/local/bin/serve

EXPOSE 80 8000 443
CMD service nginx start && service php5.6-fpm start && tail -F /var/log/nginx/*