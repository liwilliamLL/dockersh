#!/bin/sh

cd $(dirname $0)
container=$(docker ps -a -q --filter="name=$(basename $(pwd))")
if [ $container ];then
        docker kill $container
else
        echo "$(basename $(pwd)) already stopped."
fi
