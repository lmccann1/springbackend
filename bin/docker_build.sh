#!/usr/bin/env bash
set -e
# clean up any containers running
./docker_destroy.sh
# start up test database
docker run -d \
-p 3306:3306 \
-p 33060:33060 \
--name accountmanager-mysql \
-e MYSQL_ROOT_PASSWORD=password \
-e MYSQL_DATABASE=accountmanager mysql:5.7
echo "getting artifact and version"
artifactId_and_version=$(mvn -q -Dexec.executable="echo" -Dexec.args='${project.artifactId}::${project.version}' --non-recursive org.codehaus.mojo:exec-maven-plugin:1.3.1:exec 2>/dev/null)
artifactId=$(echo ${artifactId_and_version} | awk -F '::' '{ print $1 }')
version=$(echo ${artifactId_and_version} | awk -F '::' '{ print $2 }')
echo "building project"
mvn clean package
echo "building docker image for ${artifactId}:${version}"
docker build -t bobcrutchley/${artifactId}:latest --build-arg artifactId=${artifactId} --build-arg version=${version} .
# get rid off test database
./docker_destroy.sh
# remove dangling containers
if [ -n "$(docker images -qa -f "dangling=true")" ]
then
    docker rmi $(docker images -qa -f "dangling=true")
fi

