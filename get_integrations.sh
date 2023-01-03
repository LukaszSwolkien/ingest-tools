#!/bin/bash
while getopts i:t: flag
do
    case "${flag}" in
        i) api_endpoint=${OPTARG};;
        t) secret=${OPTARG};;
    esac
done

echo "* Get integration data from the endpoint: $api_endpoint"
curl -X GET $api_endpoint -H "Content-Type: application/json" -H "X-SF-TOKEN: $secret" -i
