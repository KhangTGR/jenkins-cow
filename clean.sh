#! /bin/bash

docker rm -f $(docker ps -aq)
docker rmi $(docker images)
docker network prune
docker volume prune
