#!/bin/bash
maxTryTimes=10

for ((i=1;i <= maxTryTimes; i++)); do
    echo "try setup mongodb replica ${i} ..."
    docker exec mongodb_app_data1_1 mongo --port 27017 /src/app/setup.js> /dev/null 2>&1 && break || sleep 1
done

if (( $i <= $maxTryTimes )); then
    echo "mongodb replica setup success!"
else
    echo "mongodb replica setup failed!"
fi 
