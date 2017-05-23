#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Expecting one argument'
    exit 0
fi

docker network create \
  --driver bridge \
  atlassian-confluence-network

docker run \
  --name atlassian-confluence-postgres \
  -e POSTGRES_USER=confluence \
  -e POSTGRES_PASSWORD="$1" \
  -v atlassian-confluence-postgres-data:/var/lib/postgresql/data \
  --net atlassian-confluence-network \
  -d \
  postgres:9.5.6-alpine

docker run \
  --name atlassian-confluence \
  -p 8090:8090 \
  -p 8091:8091 \
  -v atlassian-confluence-home:/var/atlassian/application-data/confluence \
  --net atlassian-confluence-network \
  -d \
  atlassian-confluence
