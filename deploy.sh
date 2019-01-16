#!/bin/bash

chmod 600 deploy.rsa
eval $(ssh-agent)
ssh-add deploy.rsa

ssh -oStrictHostKeyChecking=no root@$IP <<EOF
    if [ ! -d $DEPLOY_DIR ]; then
        mkdir $DEPLOY_DIR
    fi
EOF

scp -oStrictHostKeyChecking=no -rp app root@$IP:$DEPLOY_DIR

ssh -oStrictHostKeyChecking=no root@$IP <<EOF
    cd $DEPLOY_DIR
    if [ "$(docker ps -a -q)" ]; then
        docker stop $(docker ps -a -q)
        docker rm $(docker ps -a -q)
    fi
    docker-compose -f docker-compose-total.yml -p mongodb up -d && bash setup.sh
EOF