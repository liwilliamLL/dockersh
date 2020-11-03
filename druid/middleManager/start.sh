#!/bin/sh

cd $(dirname $0)
cwd=$(pwd)
service=$(basename $(pwd))
cd ..
namespace=$(basename $(pwd))
cd ${cwd}
if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
        echo "Create docker network 'dev'."
        docker network create dev || echo "The docker network 'dev' is already created."
fi
docker run --name ${namespace}_${service} -d --rm --network dev -p 8091:8091 -v $(pwd)/../conf:/usr/local/druid/conf -v $(pwd)/data:/usr/local/druid/var  -v $(pwd)/log:/usr/local/druid/log -e DRUID_XMX=1g -e DRUID_XMS=1g -e DRUID_MAXNEWSIZE=250m -e DRUID_NEWSIZE=250m -e DRUID_HOSTNAME=${namespace}_${service} registry.cn-shenzhen.aliyuncs.com/dms/druid:latest middleManager
