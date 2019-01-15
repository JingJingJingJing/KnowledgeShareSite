#!/bin/bash

chmod 600 deploy.rsa
eval $(ssh-agent)
ssh-add deploy.rsa

ssh -oStrictHostKeyChecking=no root@$IP <<EOF
    if [ ! -d $DEPLOY_DIR ]; then
        mkdir $DEPLOY_DIR
    fi
EOF

scp -oStrictHostKeyChecking=no app/docker-compose-total.yml root@$IP:$DEPLOY_DIR/docker-compose-total.yml

ssh -oStrictHostKeyChecking=no root@$IP <<EOF
    cd $DEPLOY_DIR
    if [ "$(docker ps -a -q)" ]; then
        docker stop $(docker ps -a -q)
        docker rm $(docker ps -a -q)
    fi
    docker-compose -f app/docker-compose-total.yml -p mongodb up -d && bash ./app/setup.sh
EOF