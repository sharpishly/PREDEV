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

# Set permissions
sudo chmod -R 755 ~/Documents/PREDEV/SharpishlyApp/app/dev.sharpishly.com/website
sudo chown -R $USER:$USER ~/Documents/PREDEV/SharpishlyApp/app/dev.sharpishly.com/website

