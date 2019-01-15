#!/bin/bash

ssh root@$server_address <<EOF
    if [ "$(docker ps -a -q)" ]; then
        docker stop $(docker ps -a -q)
        docker rm $(docker ps -a -q)
    fi
    docker-compose -f ./app/docker-compose-total.yml -p mongodb up -d && bash ./app/setup.sh
EOF