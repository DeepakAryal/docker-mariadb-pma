# Phpmyadmin and Mariadb using docker 

## Clone  docker-mariadb-pma
```bash
git@github.com:DeepakAryal/docker-mariadb-pma.git
```

### Copy `.env.example` to `.env` and update the environment variables as appropriate

```bash
cp .env.example .env
```

### Start container
```bash
make start
```

This will create a docker container for phpmyadmin and mariadb

### Stop container
```bash
make stop
```
