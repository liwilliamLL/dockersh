#!/bin/sh

cd $(dirname $0)
cwd=$(pwd)
for i in $(ls -d */ | grep -v conf); do
	cd ${cwd}
	sh "$(pwd)/${i}stop.sh"
done
