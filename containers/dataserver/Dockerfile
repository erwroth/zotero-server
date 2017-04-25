FROM php:5.6-apache

ENV MEMCACHED_VERSION 2.2.0

# Set up PHP and extensions
RUN apt-get update && apt-get install -y \
		wget \
		python python-pip \
		mysql-client \
		git \
		libxml2-dev \
		mysql-client \
		libmemcached11 libmemcachedutil2 build-essential libmemcached-dev libz-dev \
		zlib1g-dev libicu-dev g++ \

	# Amazon Web Services command line tool
	&& pip install awscli \

	# Install mysql ext
	&& docker-php-ext-install -j$(nproc) mysqli \
	&& docker-php-ext-enable mysqli \

	# Install igbinary
	&& pecl install igbinary \

	# Install memcached w/ igbinary support
	&& pecl download memcached-$MEMCACHED_VERSION \
	&& tar xzvf memcached-$MEMCACHED_VERSION.tgz \
	&& cd memcached-$MEMCACHED_VERSION \
	&& phpize \
	&& ./configure --enable-memcached-igbinary \
	&& make \
	&& make install \

	# Install intl ext
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install intl \

	# Enable extensions
	&& docker-php-ext-enable intl igbinary memcached \

	&& docker-php-ext-install zip \

	&& pear install HTTP_Request2 \

	# Get composer
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \

	# Clone patched dataserver branch
	&& cd /var/www/ \
	&& git  clone -b tmp/docker --single-branch --recursive https://github.com/mrtcode/dataserver \
	&& cd dataserver \
	&& composer install \
	&& mkdir -p tmp/cache \
	&& chmod ugo+rwx -R tmp \

	# Install Zend libraries to dataserver/include/Zend/
	&& cd /tmp \
	&& wget -O zend.tar.gz https://packages.zendframework.com/releases/ZendFramework-1.12.20/ZendFramework-1.12.20.tar.gz \
	&& mkdir zend \
	&& tar -zxf zend.tar.gz -C zend --strip-components=1 \
	&& mv zend/library/Zend/* /var/www/dataserver/include/Zend/ \

	# Install required dependencies for the new Elastica version
	&& cd /var/www/dataserver \
	&& composer require psr/log:dev-master \
	&& composer require elasticsearch/elasticsearch \
	&& cd include \
	&& rm -rf Elastica \
	&& git clone --branch 5.2.0 https://github.com/ruflin/Elastica \

	# Enable apache rewrite
	&& a2enmod rewrite \

	# Disable Apache default site
	&& a2dissite 000-default \

	# Cleanup
	&& apt-get remove -y build-essential libmemcached-dev libz-dev libxml2-dev libicu-dev \
	&& apt-get autoremove -y \
	&& apt-get clean \
	&& rm -rf /tmp/pear \
	&& rm -rf /tmp/zend \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/www/html/*

# Temporary hack to allow interacting with localstack
RUN mkdir ~/.aws \
	&& bash -c 'echo -e "[default]\nregion = us-east-1" > ~/.aws/config' \
	&& bash -c 'echo -e "[default]\naws_access_key_id = test\naws_secret_access_key = test" > ~/.aws/credentials'

ADD dataserver.conf /etc/apache2/sites-available/
RUN a2ensite dataserver

ADD gzip.conf /etc/apache2/conf-available/
RUN a2enconf gzip

ADD ./dataserver /var/www/dataserver

RUN chmod ugo+x /var/www/dataserver/misc/init-mysql.sh

WORKDIR /var/www/dataserver
