#!make
include .env
export $(shell sed 's/=.*//' .env)

clean: stop
	@printf "\033[0;32m>>> Cleaning up database data\033[0m\n"
	docker volume rm ${PROJECT}_mariadb-data

export:
	@printf "\033[0;32m>>> Dumping MariaDB database\033[0m\n"
	docker exec -it ${PROJECT}-mariadb mysqldump \
		-u${PROJECT} \
		-p${PROJECT} \
		--no-data \
		${PROJECT} > mariadb/fixtures/${PROJECT}.sql
	docker exec -it ${PROJECT}-mariadb mysqldump \
		-u${PROJECT} -p${PROJECT} --no-create-info \
		# --ignore-table ...
		-c ${PROJECT} | awk '{gsub(/\),/, "&\n")}1' | awk '{gsub(/ VALUES /, " VALUES\n")}1' \
		>> mariadb/fixtures/${PROJECT}.sql
	gzip -k fixtures/${PROJECT}.sql
	rm fixtures/mariadb/${PROJECT}.sql

image:
	@printf "\033[0;32m>>> Building database server image\033[0m\n"
	docker build -t database/test-db:local ./mariadb

start:
	@printf "\033[0;32m>>> Starting local services\033[0m\n"
	docker compose -p ${PROJECT} up -d

stop:
	@printf "\033[0;32m>>> Stopping local services\033[0m\n"
	docker compose -p ${PROJECT} down \
		--remove-orphans \
		--rmi local
