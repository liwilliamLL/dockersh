#!/bin/sh

if [ $# -ne 1 ];then
        echo "usage: $0 service"
        exit 0
fi

if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
	echo "Create docker network 'dev'."
	docker network create dev || echo "The docker network 'dev' is already created."
fi

docker run -it --network dev --name ping --rm alpine /bin/sh -c "ping $1"
