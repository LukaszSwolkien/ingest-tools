#!/bin/bash
secrets_file=".secrets.yaml"


read_token_from_yaml() {
    secret=$(grep SPLUNK_API_TOKEN $secrets_file | tr -d '"'); 
    secret=${secret//*SPLUNK_API_TOKEN: /};
}


read_api_endpoint() {
    api_endpoint=$(grep SPLUNK_API $secrets_file | tr -d '"')
    api_endpoint=${api_endpoint//*SPLUNK_API: /}
}

if [ -f "$secrets_file" ]
then
    read_token_from_yaml
    read_api_endpoint
    echo "* Get integration data from the endpoint: $api_endpoint"
    curl -X GET $api_endpoint -H "Content-Type: application/json" -H "X-SF-TOKEN: $secret" -i
else
    echo "$secrets_file not found"
fi