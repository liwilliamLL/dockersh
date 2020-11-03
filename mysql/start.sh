#!/bin/sh

cd $(dirname $0)
if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
        echo "Create docker network 'dev'."
        docker network create dev || echo "The docker network 'dev' is already created."
fi
docker run --name $(basename $(pwd)) -d  --restart always --network dev -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -v $(pwd)/data:/var/lib/mysql mariadb:latest
