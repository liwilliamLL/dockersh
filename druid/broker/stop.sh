#!/bin/sh

cd $(dirname $0)
cwd=$(pwd)
service=$(basename $(pwd))
cd ..
namespace=$(basename $(pwd))
cd ${cwd}
container=$(docker ps -a -q --filter="name=${namespace}_${service}")
if [ $container ];then
        docker kill $container
else
        echo "${namespace}_${service} already stopped."
fi
