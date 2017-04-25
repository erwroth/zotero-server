#!/usr/bin/env bash

echo "Running dataserver remote tests"
docker-compose exec dataserver bash -c " \
	cd /var/www/dataserver/tests/remote \
	&& ./phpunit --debug tests/API/ --exclude-group s3,sns,attachment,api-sync
	"

