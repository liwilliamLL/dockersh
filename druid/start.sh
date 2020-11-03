#!/bin/sh

cd $(dirname $0)
if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
        echo "Create docker network 'dev'."
        docker network create dev || echo "The docker network 'dev' is already created."
fi
cwd=$(pwd)
for i in $(ls -d */ | grep -v conf); do
	cd ${cwd}
	sh "$(pwd)/${i}start.sh"
done
