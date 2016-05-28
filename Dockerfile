FROM debian:latest
MAINTAINER Eugene Min <e.min@milax.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y \
    sudo \
    nano \
    wget \
    curl

RUN rm /var/lib/apt/lists/*gz
RUN apt-get -o Acquire::GzipIndexes=false update

RUN wget http://repo.ajenti.org/debian/key -O- | apt-key add -
RUN echo "deb http://repo.ajenti.org/debian main main debian" >> /etc/apt/sources.list

RUN apt-get update -y
RUN apt-get install -y -f ajenti
RUN apt-get install -y ajenti-v ajenti-v-nginx ajenti-v-php-fpm php5-mysql php5-memcached php5-mcrypt php5-gd php5-sqlite php5-pgsql php5-xdebug

RUN echo "www-data ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN wget https://getcomposer.org/download/1.1.1/composer.phar && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
RUN wget https://phar.phpunit.de/phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit && chmod +x /usr/local/bin/phpunit

WORKDIR /srv

RUN apt-get install -y php5-curl
RUN rm /etc/ajenti/config.json
COPY ./scripts/config.json /etc/ajenti/config.json
COPY ./scripts/ajenti.conf /etc/nginx/conf.d/ajenti.conf

EXPOSE 80 8000 443
CMD service ajenti start && sleep 10 && ajenti-ipc v apply && tail -f /var/log/nginx/*