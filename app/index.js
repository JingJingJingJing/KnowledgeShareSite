const os = require('os');

const mongoClient = require('mongodb').MongoClient;
const dbConfig = require('./datasources.json');

const express = require('express');
const appConfig = require('./app.json');
const app = express();

app.get('/', (req, res) => {
    mongoClient.connect(dbConfig.protocol + dbConfig.hosts + '/?' + "replicaSet:" + dbConfig.replicaSet,{ useNewUrlParser: true }, function (err, client) {
        console.log(dbConfig.protocol + dbConfig.hosts + '/?' + "replicaSet:" + dbConfig.replicaSet);
        const col = client.db(dbConfig.db).collection('helloworld');
        col.insertOne({"sateam":"helloworld!"});
        col.find({}).toArray(function (err, items) {
            res.send(os.hostname() + '\n' + JSON.stringify(items));
            client.close();
        });
    });
});

app.listen(appConfig.port, () => console.log(`Example app listening on port ${appConfig.port}!`));