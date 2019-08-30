#!/bin/bash

confluenceHome=$(docker volume inspect --format '{{ .Mountpoint }}' atlassian-confluence-home)

echo Confluence Home Volume location is $confluenceHome
mkdir -p backup
cp $confluenceHome/backups/xmlexport*.zip backup/.

echo Backup complete

