# DOCKERERIZE MARIADB AND PHPMYADMIN 

## Requirements
* [Docker Compose V2](https://docs.docker.com/compose/cli-command/)

## Clone  docker-mariadb-pma
```bash
git@github.com:DeepakAryal/docker-mariadb-pma.git
```
### Setup environment variable
```bash
cp .env.example .env
```
### Start container
```bash
make start
```
This will startup docker container for phpMyAdmin, MariaDB
### Usage
1. phpMyAdmin
    The `phpMyAdmin` will be available at url: `http://localhost:50016`
    Login credential:
    * Username: `test_user`
    * Password: `test_password`

### Stop container
```bash
make stop
```
This will shutdown docker container for phpMyAdmin, MariaDB.
## docker-mariadb-pma (WITH DOCKER)
This docker-mariadb-pma is for use in local development.

