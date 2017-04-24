
.PHONY: up

setup:
	./setup.sh

build:
	docker-compose build
	docker-compose pull

up:
	docker-compose up

down:
	docker-compose down

init-localstack-s3:
	docker-compose exec dataserver bash -c " \
	aws --endpoint-url "http://localstack:4572" s3 mb s3://zotero \
	"
init-localstack-sns:
	docker-compose exec dataserver bash -c " \
	aws --endpoint-url "http://localstack:4575" sns create-topic --name zotero \
	"

init-mysql:
	docker-compose exec dataserver bash -c " \
	cd /var/www/dataserver/misc \
	&& ./test_reset \
	"
init-elasticsearch:
	docker-compose exec dataserver bash -c " \
	cd /var/www/dataserver/misc/elasticsearch \
	&& ./bin/init elasticsearch a \
	"

test:
	./test.sh