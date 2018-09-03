#!/usr/bin/env bash
set -e

for container in account-manager-java-spring accountmanager-mysql
do
    if [ -n "$(docker ps | grep ${container})" ]
    then
        docker stop ${container}
    fi
    if [ -n "$(docker ps -a | grep ${container})" ]
    then
        docker rm ${container}
    fi
done
