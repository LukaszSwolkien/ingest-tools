#!/bin/bash
secrets_file=".secrets.yaml"

read_token_from_yaml() {
    secret=$(grep splunk-ingest-token $secrets_file | tr -d '"'); 
    secret=${secret//*splunk-ingest-token: /};
}


read_ingest_endpoint() {
    ingest_endpoint=$(grep splunk-ingest $secrets_file | tr -d '"')
    ingest_endpoint=${ingest_endpoint//*splunk-ingest: /}
    # ingest_endpoint="${ingest_endpoint}/services/collector/event"
    ingest_endpoint="${ingest_endpoint}/v1/log"
}

sev_array[0]="DEBUG"
sev_array[1]="INFO"
sev_array[2]="WARN"
sev_array[3]="ERROR"
sev_size=${#sev_array[@]}
sev_idx=$(($RANDOM % $sev_size))

if [ -f "$secrets_file" ]
then
    read_ingest_endpoint
    echo "* Ingest endpoint: $ingest_endpoint"
    read_token_from_yaml
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
else
    echo "$secrets_file not found"
fi
