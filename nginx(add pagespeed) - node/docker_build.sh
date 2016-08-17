#!/bin/sh
version=1.0

echo "################## docker bulid start ##################"
docker stop $(docker ps -a -q)
docker rm $(docker ps -aq)
docker build --tag hoho0443:$version .
echo "################## docker bulid done ##################"

echo "################## docker run ##################"
docker run --name hoho0443 -d -p 9999:80 hoho0443:$version
echo "##################"
echo "if you want join Docker image, "
echo "run below command"
echo "docker exec -it hoho0443 /bin/bash"
echo "##################"

echo "################## docker ps ##################"
docker ps
#docker exec -it hoho0443 /bin/bash
