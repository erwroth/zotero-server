#!/usr/bin/env bash

#echo "dataserver local tests"
#docker-compose exec dataserver bash -c " \
#	cd /var/www/dataserver/tests/local \
#	&& ./phpunit tests \
#	"

echo "dataserver remote tests"
docker-compose exec dataserver bash -c " \
	cd /var/www/dataserver/tests/remote \
	&& ./phpunit --debug tests/API/ --exclude-group exclude
	"

