#!/bin/sh

cd $(dirname $0)

if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
        echo "Create docker network 'dev'."
        docker network create dev || echo "The docker network 'dev' is already created."
fi
docker run --name $(basename $(pwd)) -d --restart always --network dev -p 9092:9092 -v $(pwd)/data:/opt/kafka/data -v $(pwd)/logs:/opt/kafka/logs --entrypoint /opt/kafka/bin/kafka-server-start.sh  solsson/kafka:0.11.0.0 /opt/kafka/config/server.properties  --override zookeeper.connect=zookeeper:2181/kafka --override advertised.listeners=PLAINTEXT://$(ifconfig | grep 'inet.*netmask.*broadcast' | awk '{print $2}'):9092
