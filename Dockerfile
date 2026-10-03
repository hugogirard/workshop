# Serves the static Fabric workshop hub + every workshop for Azure Container Instances.
# Listens on 8080 so a Caddy sidecar can own 80/443 for HTTPS in the container group.
FROM nginx:alpine

COPY deployment/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
COPY workshops/ /usr/share/nginx/html/workshops/

EXPOSE 8080
