#!/bin/bash
secrets_file=".secrets.yaml"


read_token_from_yaml() {
    secret=$(grep splunk-ingest-token $secrets_file | tr -d '"'); 
    secret=${secret//*splunk-ingest-token: /};
}


read_ingest_endpoint() {
    ingest_endpoint=$(grep splunk-ingest $secrets_file | tr -d '"')
    ingest_endpoint=${ingest_endpoint//*splunk-ingest: /}
    ingest_endpoint="${ingest_endpoint}/v2/trace"
}


if [ -f "$secrets_file" ]
then
    read_ingest_endpoint
    echo "* Ingest endpoint: $ingest_endpoint"
    read_token_from_yaml
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
else
    echo "$secrets_file not found"
fi


# curl -X POST https://external-ingest.lab0.signalfx.com/v2/datapoint -H "Content-Type: application/json" -H "X-SF-Token: $secret" -d '{"gauge": [{"metric": "heartbeat", "value": 100}]}' -i
