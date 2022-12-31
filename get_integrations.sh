#!/bin/bash
secrets_file=".secrets.yaml"


read_token_from_yaml() {
    secret=$(grep splunk-api-token $secrets_file | tr -d '"'); 
    secret=${secret//*splunk-api-token: /};
}


read_api_endpoint() {
    api_endpoint=$(grep splunk-api $secrets_file | tr -d '"')
    api_endpoint=${api_endpoint//*splunk-api: /}
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