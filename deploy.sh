#!/bin/bash

IP="128.199.81.210"
DEPLOY_DIR="/ks"

scp app/docker-compose-total.yml username@a:$DEPLOY_DIR/docker-compose-total.yml 

ssh -o root@$IP <<EOF
    cd $DEPLOY_DIR
    if [ "$(docker ps -a -q)" ]; then
        docker stop $(docker ps -a -q)
        docker rm $(docker ps -a -q)
    fi
    docker-compose -f app/docker-compose-total.yml -p mongodb up -d && bash ./app/setup.sh
EOF