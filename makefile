#!make
include .env
export $(shell sed 's/=.*//' .env)

# ---------------------------------------
# DATABASE COMMANDS
# ---------------------------------------

build: image

clean:
	docker stop mariadb && docker rm mariadb && docker rmi database/test-db:local

db.start:
	@printf "\033[0;32m>>> Starting database server via docker-compose\033[0m\n"
	docker-compose -f docker-compose.local.yml up -d mariadb

image:
	@printf "\033[0;32m>>> Building database server image\033[0m\n"
	docker build -t database/test-db:local ./mariadb

reset:
	gunzip < mariadb/fixtures/database.sql.gz | docker exec -i mariadb mysql -u$$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE

# ---------------------------------------
# PHPMyAdmin COMMANDS
# ---------------------------------------

pma.start:
	@printf "\033[0;32m>>> Starting phpMyAdmin via docker-compose\033[0m\n"
	docker-compose -f docker-compose.local.yml up -d pma


start:
	@printf "\033[0;32m>>> Starting all services via docker-compose\033[0m\n"
	docker-compose -f docker-compose.local.yml up -d

stop:
	@printf "\033[0;32m>>> Stopping all services via docker-compose\033[0m\n"
	docker-compose -f docker-compose.local.yml down --rmi local -v --remove-orphans

# ---------------------------------------
# DATABASE IMPORT / EXPORT
# ---------------------------------------

unzip:
	gunzip -k ./mariadb/fixtures/database.sql.gz

zip:
	gzip -k ./mariadb/fixtures/database.sql
