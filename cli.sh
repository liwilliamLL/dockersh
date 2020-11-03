#!/bin/sh

if [ $# -ne 1 ];then
	echo "usage: $0 service"
	exit 0
fi

cd $(dirname $0)
sh "$(pwd)/$1/cli.sh" || echo "can't cli $1"
