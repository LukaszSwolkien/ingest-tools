#!/bin/bash

while getopts i:t: flag
do
    case "${flag}" in
        i) ingest_endpoint=${OPTARG};;
        t) secret=${OPTARG};;
    esac
done
echo "* Ingest endpoint: $ingest_endpoint"
echo "* Access token: $secret";

ts=$(date +%s)
dur=$(shuf -i 2000-10000 -n 1)
# Zipkin format
# Doc: https://zipkin.io/zipkin-api/#/default/post_spans 
payload='
[
    {
        "name": "sample-trace-generator",
        "id": "1",
        "traceId": "10",
        "parentId": "100",
        "timestamp": '$ts',
        "duration": '$dur',
        "kind": "SERVER",
        "localEndpoint": 
        {
            "serviceName": "backend",
            "ipv4": "192.168.99.1",
            "port": 3306
        },
        "remoteEndpoint": 
        {
            "ipv4": "172.19.0.2",
            "port": 58648
        },
        "tags": 
        {
            "http.method": "SET",
            "http.path": "/api"
        }
    }
]'
echo "* Sending sample data: $payload"
curl -X POST $ingest_endpoint -H "Content-Type: application/json" -H "X-SF-Token: $secret" -d "$payload" -i



# curl -X POST https://external-ingest.lab0.signalfx.com/v2/datapoint -H "Content-Type: application/json" -H "X-SF-Token: $secret" -d '{"gauge": [{"metric": "heartbeat", "value": 100}]}' -i
