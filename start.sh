#!/bin/sh

if [ $# -eq 0 ];then
	echo "usage: $0 service1 [service2 [service3 ...]]"
	exit 0
fi

if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
	echo "Create docker network 'dev'."
	docker network create dev || echo "The docker network 'dev' is already created."
fi

cd $(dirname $0)
cwd=$(pwd)
for i in "$@"; do
	cd ${cwd}
	sh "$(pwd)/$i/start.sh" || echo "start $i failed"
done
