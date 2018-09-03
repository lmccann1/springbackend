#!/usr/bin/env bash
set -e
./docker_destroy.sh

if [ -z "$(docker images | grep account-manager-java-spring)" ]
then
    echo "image for account-manager-java-spring not found, building now"
    ./docker_build.sh
fi

docker run -d \
-p 3306:3306 \
-p 33060:33060 \
--name accountmanager-mysql \
-e MYSQL_ROOT_PASSWORD=password \
-e MYSQL_DATABASE=accountmanager mysql:5.7

docker run -d \
-p 8080:8080 \
--name account-manager-java-spring \
--link accountmanager-mysql:mysql \
bobcrutchley/account-manager-java-spring:latest

