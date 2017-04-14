# zotero-server

A simple Zotero 5.0 server setup based on Docker.

zotero-server uses a [special dataserver fork](https://github.com/mrtcode/dataserver/tree/tmp/docker)
until all required customizations will be merged into the main repository.

The full zotero-server will have all required packages to run a fully fledged Zotero server.
Currently there are:

- dataserver
- tinymce-clean-server
- stream-server
- citeproc-node

## Setup and run

```
git clone https://github.com/mrtcode/zotero-server
cd zotero-server
make setup
```

Now configuration scripts are generated. Customize them and then start building:

```
make build
```

To run Elasticsearch, it needs an increased vm_max_map_count setting on your Docker host:

```
sysctl -w vm.max_map_count=262144
```

Start all services:
```
make up
```


Wait until all databases are stared and then initialize schema with initial data:

```
make init-mysql
make init-elasticsearch
make init-localstack-s3
```

A test user will be created. You can use it with Zotero client:

```
testuser:test
```

zotero-server is now accessible on

```
172.13.0.1:80
```


## Test

```
make test
```

# Stop
```
make down
```

## Manually control services

All services you can see in docker-compose.yml.
Each of them can be controlled directly with docker-compose.

```
docker-compose up/down/build [service name]
```

Attach console:

```
docker-compose exec [service-name] bash
```

## Amazon Web Services

Some Zotero functions depend on Amazon services:

- S3 - file uploads
- SNS - file uploads, updated items notifications
- SQS - updated items notifications

zotero-server currently uses [localstack](https://github.com/atlassian/localstack)
to emulate AWS services.






