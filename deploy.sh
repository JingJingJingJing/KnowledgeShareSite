#!/bin/bash

chmod 600 deploy.rsa
eval $(ssh-agent)
ssh-add deploy.rsa

ssh -oStrictHostKeyChecking=no root@$server_address <<EOF
    if [ ! -d $DEPLOY_DIR ]; then
        mkdir $DEPLOY_DIR
    fi
EOF

scp -oStrictHostKeyChecking=no -rp app root@$server_address:$DEPLOY_DIR

ssh -oStrictHostKeyChecking=no root@$server_address <<EOF
    cd $DEPLOY_DIR/app
    docker pull gemmawu/sasharingapp:1.0
    docker-compose -f docker-compose-total.yml -p mongodb up -d && bash setup.sh
EOF
    