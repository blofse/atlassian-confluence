#!/bin/sh

echo Stopping existing container
docker stop atlassian-confluence-postgres
docker stop atlassian-confluence

echo Copying and running service
yes | cp optional/docker-atlassian-confluence-postgres.service /etc/systemd/system/.
yes | cp optional/docker-atlassian-confluence.service /etc/systemd/system/.
systemctl daemon-reload

systemctl enable docker-atlassian-confluence-postgres
systemctl enable docker-atlassian-confluence

systemctl start docker-atlassian-confluence-postgres
systemctl start docker-atlassian-confluence
echo Done!
