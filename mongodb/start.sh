#!/bin/sh

cd $(dirname $0)
if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
        echo "Create docker network 'dev'."
        docker network create dev || echo "The docker network 'dev' is already created."
fi
docker run --name $(basename $(pwd)) -d --restart always --network dev -p 27017:27017 -v $(pwd)/data:/data/db -v $(pwd)/log:/var/log/mongodb mongo:3.4
