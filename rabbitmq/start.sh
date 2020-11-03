#!/bin/sh

cd $(dirname $0)
if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
        echo "Create docker network 'dev'."
        docker network create dev || echo "The docker network 'dev' is already created."
fi
docker run --name $(basename $(pwd)) -d --restart always --network dev -p 4369:4369 -p 5671-5672:5671-5672 -p 25672:25672 -v $(pwd)/etc:/etc/rabbitmq -v $(pwd)/data:/var/lib/rabbitmq -v $(pwd)/log:/var/log/rabbitmq -e RABBITMQ_DEFAULT_VHOST='/' -e RABBITMQ_DEFAULT_USER='admin' -e RABBITMQ_DEFAULT_PASS='qwertyuiop' -e RABBITMQ_LOGS='/var/log/rabbitmq/rabbitmq_logs' -e RABBITMQ_SASL_LOGS='/var/log/rabbitmq/rabbitmq_sasl_logs' rabbitmq
