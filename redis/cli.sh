#!/bin/sh

cd $(dirname $0)
docker exec -it $(basename $(pwd)) redis-cli
