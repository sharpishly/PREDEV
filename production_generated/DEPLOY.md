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
