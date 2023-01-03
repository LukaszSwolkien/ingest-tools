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

sev_array[0]="DEBUG"
sev_array[1]="INFO"
sev_array[2]="WARN"
sev_array[3]="ERROR"
sev_size=${#sev_array[@]}
sev_idx=$(($RANDOM % $sev_size))
value=$(shuf -i 1000-9000 -n 1)
host=$(uname -n)
ts=$(date +%s)

# Payload in HTTP Event Collector (HEC) format
# Doc: https://docs.splunk.com/Documentation/Splunk/8.0.5/Data/FormateventsforHTTPEventCollector
payload='
{
    "time": '$ts',
    "host": "'"$host"'",
    "source": "sample-log-generator",
    "sourcetype": "sample-log",
    "event": { 
        "message": "Something happened",
        "severity": "'"${sev_array[$sev_idx]}"'"
    },
    "fields":     {
            "group_name":   "sampler"
    }
}
'

echo "* Sending sample data: $payload"
curl -X POST $ingest_endpoint -H "Content-Type: application/json" -H "X-SF-Token: $secret" -d "$payload" -i

