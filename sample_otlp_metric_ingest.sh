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

value=$(shuf -i 1-100 -n 1)
host=$(uname -n)
payload=''
echo "* Sending sample metric: $payload"
curl -X POST $ingest_endpoint -H "Content-Type: application/x-protobuf" -H "X-SF-Token: $secret" -d "$payload" -i
