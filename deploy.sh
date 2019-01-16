#!/bin/bash

chmod 600 deploy.rsa
eval $(ssh-agent)
ssh-add deploy.rsa

ssh -oStrictHostKeyChecking=no root@128.199.81.210 <<EOF
    if [ ! -d /ks ]; then
        mkdir /ks
    fi
EOF

scp -oStrictHostKeyChecking=no -rp app root@128.199.81.210:/ks

ssh -oStrictHostKeyChecking=no root@128.199.81.210 <<EOF
    cd /ks/app
    if [ "$(docker ps -a -q)" ]; then
        echo "exist running containers"
        docker stop $(docker ps -a -q)
        docker rm $(docker ps -a -q)
    fi
    docker-compose -f docker-compose-total.yml -p mongodb up -d && bash setup.sh
EOF
    