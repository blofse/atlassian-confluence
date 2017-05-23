#!/bin/bash

echo Stopping/removing services
systemctl stop docker-atlassian-confluence-postgres
systemctl stop docker-atlassian-confluence

systemctl disable docker-atlassian-confluence-postgres
systemctl disable docker-atlassian-confluence

if [ -f /etc/systemd/system/docker-atlassian-confluence.service ]; then
  rm -fr /etc/systemd/system/docker-atlassian-confluence.service
fi
if [ -f /etc/systemd/system/docker-atlassian-confluence-postgres.service ]; then
  rm -fr /etc/systemd/system/docker-atlassian-confluence-postgres.service
fi

systemctl daemon-reload

echo Kill/remove docker images
docker stop atlassian-confluence-postgres || true && docker rm atlassian-confluence-postgres || true
docker stop atlassian-confluence || true && docker rm atlassian-confluence || true

echo Removing volumes
docker volume rm atlassian-confluence-postgres-data || true
docker volume rm atlassian-confluence-home || true

echo Removing networks
docker network rm atlassian-confluence-network || true

echo Removing docker image - confluence only
docker rmi atlassian-confluence

echo Done!