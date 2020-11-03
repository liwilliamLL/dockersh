#!/bin/sh

cd $(dirname $0)
if [ $(docker network ls | grep dev | wc -l | xargs) = "0" ];then
        echo "Create docker network 'dev'."
        docker network create dev || echo "The docker network 'dev' is already created."
fi
mkdir -p $(pwd)/data/logs
docker run --restart always --network dev -v $(pwd)/tables_xxl_job.sql:/tmp/tables_xxl_job.sql mariadb:latest /bin/sh -c 'mysql -h mysql -P 3306 -uroot -proot --default-character-set=utf8 < /tmp/tables_xxl_job.sql'
docker run --name $(basename $(pwd)) -d  --restart always \
	--network dev \
	-p 10080:8080 \
	-e PARAMS="--spring.datasource.url=jdbc:mysql://mysql:3306/xxl_job?Unicode=true&characterEncoding=UTF-8 --spring.datasource.password=root" \
	-v $(pwd)/data/logs:/data/applogs \
	xuxueli/xxl-job-admin:2.0.2
