#!/bin/bash

line='--------------'

echo "$line Start Sharpishly"
docker-compose up -d

echo "$line Start PHP"
cd SharpishlyApp/app/

docker compose -f docker-compose.local.yml up -d
docker logs nginx_proxy_local
docker logs -f nginx_proxy_local
docker logs php_fpm_local
