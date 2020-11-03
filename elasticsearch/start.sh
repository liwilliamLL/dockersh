#!/bin/sh

cd $(dirname $0)
if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
        echo "Create docker network 'dev'."
        docker network create dev || echo "The docker network 'dev' is already created."
fi
docker run --name $(basename $(pwd)) -d --network dev -p 9200:9200 -p 9300:9300 -v $(pwd)/data:/usr/share/elasticsearch/data -v $(pwd)/log:/usr/share/elasticsearch/logs -v $(pwd)/etc/jvm.options:/usr/share/elasticsearch/config/jvm.options -v $(pwd)/etc/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml --ulimit memlock=-1:-1 registry.cn-shenzhen.aliyuncs.com/dms/elastic:latest --restart always mysql
