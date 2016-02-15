#!/bin/bash

#Influxdb
nohup influxd &

isReady=666
until [ ! $isReady -ne 0 ]
do
   curl http://localhost:8086/query 2> /dev/null
   isReady=$?
done

curl -G http://localhost:8086/query -d "q=CREATE%20DATABASE%20statsd"

#Grafana
service grafana-server start
curl -X POST http://localhost:3000/api/datasources -H "Content-Type: application/json" -u admin:admin -d @/usr/local/grafanaDatasource.json

statsd /usr/local/statsd.js