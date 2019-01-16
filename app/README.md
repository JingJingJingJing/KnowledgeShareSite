# KnowledgeShare
Knowledge Share Site

docker-compose.yml is the file to run the mongodb's containers.

docker-compose-app.yml is the file to run both the app's container.

docker-compose-total.yml is the file to run both the app's container and mongodb's containers,and the image: gemmawu/sasharingapp:1.0 should exist.

step1: pull images
    docker pull gemmawu/sasharingapp:1.0

step2: run containers
    docker-compose -f docker-compose-total.yml -p mongodb up -d && bash setup.sh

step3: access to database
    wait about 10 secends,visit localhost:3000
