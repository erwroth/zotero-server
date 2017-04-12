# docker-grafana-graphite makefile

.PHONY: up

up :
	docker-compose up -d

down :
	docker-compose down
