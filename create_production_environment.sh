#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="${HOME}/Documents/PREDEV"
OUT_DIR="${ROOT_DIR}/production_generated"
NGINX_DIR="${OUT_DIR}/nginx"
mkdir -p "${NGINX_DIR}"

echo "Creating production files in: ${OUT_DIR}"
echo

# production docker-compose
cat > "${OUT_DIR}/production-docker-compose.yml" <<'YAML'
version: "3.9"

services:
  # Nginx reverse proxy for all sites
  nginx:
    image: nginx:stable-alpine
    container_name: prod_nginx
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/prod.conf:/etc/nginx/conf.d/default.conf:ro
      - ./static_site:/var/www/app/sharpishly.com/website/public:ro
      - ./php_site:/var/www/app/dev.sharpishly.com/website/public:ro
      - ./certs:/etc/nginx/ssl:ro
    networks:
      - prod_net

  # PHP FPM for dev.sharpishly.com
  php:
    image: yourregistry/php-fpm:production  # replace with your production image or build step
    container_name: prod_php
    restart: unless-stopped
    environment:
      - DB_HOST=${DB_HOST}
      - DB_USER=${DB_USER}
      - DB_PASSWORD=${DB_PASSWORD}
      - DB_NAME=${DB_NAME}
    volumes:
      - ./php_site:/var/www/app/dev.sharpishly.com/website/public:ro
    networks:
      - prod_net
    depends_on:
      - db

  # Python MVC (gunicorn)
  python_mvc:
    image: yourregistry/python-mvc:production
    container_name: prod_python_mvc
    restart: unless-stopped
    environment:
      - SOME_ENV_VAR=${SOME_ENV_VAR}
    networks:
      - prod_net

  # Standalone Flask (optional)
  python_standalone:
    image: yourregistry/python-standalone:production
    container_name: prod_python_standalone
    restart: unless-stopped
    networks:
      - prod_net

  # MySQL production (consider managed DB in real production)
  db:
    image: mysql:8.0
    container_name: prod_mysql
    restart: unless-stopped
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - MYSQL_DATABASE=${DB_NAME}
      - MYSQL_USER=${DB_USER}
      - MYSQL_PASSWORD=${DB_PASSWORD}
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - prod_net

networks:
  prod_net:
    driver: bridge

volumes:
  mysql_data:
YAML

echo "Created: production-docker-compose.yml"

# nginx prod.conf
cat > "${NGINX_DIR}/prod.conf" <<'NGX'
# prod.conf - routes all domains to their appropriate services

# sharpishly.com -> static site
server {
    listen 80;
    server_name sharpishly.com www.sharpishly.com;
    root /var/www/app/sharpishly.com/website/public;
    index index.html index.htm index.php;
    access_log /var/log/nginx/sharpishly.access.log;
    error_log /var/log/nginx/sharpishly.error.log;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass prod_php:9000;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $document_root;
    }
}

# dev.sharpishly.com -> php site (dev instance)
server {
    listen 80;
    server_name dev.sharpishly.com;
    root /var/www/app/dev.sharpishly.com/website/public;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass prod_php:9000;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $document_root;
    }
}

# py.sharpishly.com -> python standalone (reverse proxy to internal container)
server {
    listen 80;
    server_name py.sharpishly.com;
    location / {
        proxy_pass http://prod_python_standalone:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# pymvc.sharpishly.com -> python mvc (gunicorn)
server {
    listen 80;
    server_name pymvc.sharpishly.com;
    location / {
        proxy_pass http://prod_python_mvc:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
NGX

echo "Created: nginx/prod.conf"

# .env.production
cat > "${OUT_DIR}/.env.production" <<'ENV'
# .env.production - copy to server (DO NOT commit secrets to git)
DB_HOST=db
DB_NAME=sharpishly_db
DB_USER=sharpishly_user
DB_PASSWORD=replace_with_secure_password
MYSQL_ROOT_PASSWORD=replace_with_secure_root_password
SOME_ENV_VAR=replace_me
ENV

echo "Created: .env.production"

# DEPLOY.md
cat > "${OUT_DIR}/DEPLOY.md" <<'DEP'
# DEPLOY.md - How to deploy the production bundle (safe, review first)

1) Copy production_generated/ to the production server (example)
   scp -r production_generated user@138.54.xx.xx:/home/deploy/production_bundle

2) On the production server:
   cd /home/deploy/production_bundle
   export $(cat .env.production | xargs)   # or use a proper envfile loader
   docker compose -f production-docker-compose.yml --env-file .env.production up -d --build

3) Verify services:
   docker ps
   docker logs prod_nginx

4) For SSL:
   - Use certbot on the host or add Traefik/Caddy for automatic HTTPS.
   - Certs in this bundle are expected under ./certs if you want Nginx to read them.

5) Rollback:
   docker compose -f production-docker-compose.yml down
   docker compose -f production-docker-compose.yml up -d --no-build

NOTES:
- This production compose uses container images placeholders (yourregistry/...), replace them with your real images or add a build step.
- For real production, I strongly recommend a managed DB (DigitalOcean managed DB) rather than running MySQL inside the same compose.
DEP

echo "Created: DEPLOY.md"

# README and ROADMAP stubs (small updates)
cat > "${OUT_DIR}/README_PRODUCTION.md" <<'RMD'
# Production bundle (generated)

This directory contains generated production artefacts:
- production-docker-compose.yml
- nginx/prod.conf
- .env.production
- DEPLOY.md

Review these files carefully before copying into the live server.
RMD

cat > "${OUT_DIR}/ROADMAP_PRODUCTION.md" <<'RMD'
# ROADMAP production additions

- Create production-docker-compose.yml (generated)
- Add Nginx production routing (prod.conf)
- Use a secrets manager for DB credentials (DO NOT commit .env.production)
- Consider Traefik or Caddy for automated HTTPS
- Use managed DB in production
RMD

echo "Created README_PRODUCTION.md and ROADMAP_PRODUCTION.md"

# List generated files
echo
echo "Generation complete. Files created:"
find "${OUT_DIR}" -maxdepth 3 -type f -print | sed "s#${ROOT_DIR}/##"

echo
echo "Security reminder: move .env.production to the server and never commit secrets to git."
echo
echo "Next steps:"
echo " 1) Review files in ${OUT_DIR}."
echo " 2) Replace placeholder images and passwords."
echo " 3) Copy to a staging server and run the compose file to test."
echo
echo "Script finished."
