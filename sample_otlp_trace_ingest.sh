#!/bin/bash

while getopts i:t: flag
do
    case "${flag}" in
        i) ingest_endpoint=${OPTARG};;
        t) secret=${OPTARG};;
        f) file=${OPTARG};;
    esac
done
echo "* Ingest endpoint: $ingest_endpoint"
echo "* Access token: $secret";

ts=$(date +%s)
dur=$(shuf -i 2000-10000 -n 1)
# OTLP format
payload=''
echo "* Sending sample data: $payload"

#echo curl -X POST $ingest_endpoint -H "Content-Type: application/x-protobuf" -H "X-SF-Token: $secret" --data-binary trace_otlp.bin -i
# curl -X POST https://ingest.rc0.signalfx.com/v2/trace/otlp -H "Content-Type: application/x-protobuf" -H "X-SF-Token: 525QqpRrIYPKw6FbqNgcvA" --data-binary trace_otlp.bin
curl -X POST $ingest_endpoint -H "Content-Type: application/x-protobuf" -H "X-SF-Token: $secret" -d $payload -i