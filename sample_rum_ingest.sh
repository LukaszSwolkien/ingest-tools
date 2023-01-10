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
payload='[]'
echo "* Sending sample data: $payload"
echo curl -X POST $ingest_endpoint -H "Content-Type: application/json" -H "X-SF-Token: $secret" -d "$payload" -i
curl -X POST $ingest_endpoint -H "Content-Type: application/json" -H "X-SF-Token: $secret" -d "$payload" -i

