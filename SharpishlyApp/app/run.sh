#!/bin/bash

line='------'

echo "$line clear terminal"
clear

echo "$line clean up previous containers"
docker compose down -v --remove-orphans
docker system prune -af
docker volume prune -f

echo "$line build steps"
docker compose up -d

echo "$line logs"
docker ps -a
docker compose logs sharpishlyapp
docker compose logs nginx
docker compose logs db


