#!/bin/bash
cd ~/Documents/PREDEV && docker-compose down
cd ~/Documents/PREDEV/SharpishlyApp/app && docker-compose down
docker compose -f docker-compose.local.yml down
docker ps -aq | xargs docker stop
docker ps -aq | xargs docker rm
