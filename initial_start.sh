#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Expecting one argument'
    exit 0
fi

docker run --name atlassian-confluence-postgres -e POSTGRES_USER=confluence -e POSTGRES_PASSWORD="$1" -v ConfluencePostgresData:/var/lib/postgresql/data -d postgres:9.5.6-alpine
docker run -d --name atlassian-confluence --link atlassian-confluence-postgres:pgconfluence -p 8090:8090 -p 8091:8091 -v ConfluenceHomeVolume:/var/atlassian/application-data/confluence atlassian-confluence
