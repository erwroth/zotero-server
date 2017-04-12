FROM ubuntu:14.04

RUN apt-get update && \
    apt-get -y install git wget curl apache2 libapache2-mod-php5 php5-cli php5-memcached \
    php5-mysql php5-curl php5-intl php5-redis php5-xdebug

RUN curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer && \
    cd /var/www/ && \
    git clone --recursive https://github.com/zotero/dataserver && \
    cd dataserver && \
    composer install && \
    cd /tmp && \
    wget -O zend.tar.gz https://packages.zendframework.com/releases/ZendFramework-1.12.20/ZendFramework-1.12.20.tar.gz && \
    mkdir zend && tar -zxf zend.tar.gz -C zend --strip-components=1 && \
    mv zend/library/Zend/* /var/www/dataserver/include/Zend/ && \
    rm -r /tmp/*

ADD include/config/config.inc.php /var/www/dataserver/include/config/

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

ADD zotero.dev.conf /etc/apache2/sites-available/

RUN sed -ri 's/^short_open_tag\s*=\s*Off/short_open_tag = On/g' /etc/php5/apache2/php.ini

RUN a2ensite zotero.dev

RUN a2ensite default-ssl
RUN a2enmod ssl && a2enmod rewrite


COPY ./run.sh /
CMD ["/run.sh"]
