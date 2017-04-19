#!/bin/sh

# if docker creates this path by itself, elasticsearch don't get required permissions
mkdir -p persistent/elasticsearch/usr/share/elasticsearch/data

cd dataserver/include/config
cp -n config.inc.php-sample config.inc.php
cp -n dbconnect.inc.php-sample dbconnect.inc.php

cd ../../tests/local/include

cp -n config.inc.php-sample config.inc.php

cd ../../remote/include

cp -n config.ini-sample config.ini