#!/usr/bin/env bash

#   SYNOPSIS:
#   1. Up postgresql
#   2. Run service
#
#   USAGE:
#   ./run_local.sh

DB_PORT=5432
DB_NAME=DB-$DB_PORT

SERVICE_PORT=8090

export ADDR=:$SERVICE_PORT
export CONN_STR="host=localhost dbname=anagram user=anagram password=123456 sslmode=disable"

echo "STOP AND DELETE OLD DB CONTAINER $DB_NAME"
docker stop $DB_NAME
docker container rm $DB_NAME
echo "START DB $DB_NAME"
docker run --name $DB_NAME -e POSTGRES_PASSWORD=123456 -e POSTGRES_USER=anagram -p $DB_PORT:$DB_PORT -d postgres

echo "Sleep 30s to up and init services"
sleep 30

echo "APPLY MIGRATIONS"
sql-migrate status -config ./data/dbconfig.yml -env dev
sql-migrate up -config ./data/dbconfig.yml -env dev

export DRIVER="postgresql"

echo "START SERVICE"
go run *.go
