#!/bin/sh

cd $(dirname $0)
if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
        echo "Create docker network 'dev'."
        docker network create dev || echo "The docker network 'dev' is already created."
fi
docker run --name $(basename $(pwd)) -d --restart always --network dev -p 8300-8302:8300-8302 -p 8301-8302:8301-8302/udp  -p 8500:8500 -p 8600:8600 -p 8600:8600/udp consul:latest agent -dev -client 0.0.0.0
