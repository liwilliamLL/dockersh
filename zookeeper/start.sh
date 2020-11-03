#!/bin/sh

cd $(dirname $0)
if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
        echo "Create docker network 'dev'."
        docker network create dev || echo "The docker network 'dev' is already created."
fi
docker run --name $(basename $(pwd)) -d --restart always --network dev -p 2181:2181 -p 2888:2888 -p 3888:3888 -v $(pwd)/log:/logs -v $(pwd)/data:/data -v $(pwd)/datalog:/datalog -v $(pwd)/conf:/conf -e ZOO_ID=1 -e ZOO_SERVERS=zookeeper -e ZOO_LOG4J_PROP="INFO,ROLLINGFILE" zookeeper
