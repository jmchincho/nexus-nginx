#!/bin/sh

tar xvf backup.tar

docker network create nexus-net

docker run -d -p 8081:8081 -p 5000:5000 --name nexus1 \
    -v $(pwd)/nexus-data:/nexus-data \
    --restart unless-stopped \
    --network nexus-net \
    sonatype/nexus3

docker run -d -p 80:80 -p 443:443 --name nginx1 \
    -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v /var/www/html/:/var/www/html:ro \
    --restart unless-stopped \
    --network nexus-net \
    nginx
