#!/bin/sh

# if docker creates this path by itself, elasticsearch don't get required permissions
mkdir -p persistent/elasticsearch/usr/share/elasticsearch/data

cd dataserver/include/config
cp config.inc.php-sample config.inc.php
cp dbconnect.inc.php-sample dbconnect.inc.php

cd ../../tests/local/include

cp config.inc.php-sample config.inc.php

cd ../../remote/include

cp config.ini-sample config.ini