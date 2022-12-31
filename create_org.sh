#!/bin/bash
secrets_file=".secrets.yaml"

read_account_trial_endpoint() {
    endpoint=$(grep SPLUNK_ACCOUNT_TRIAL $secrets_file | tr -d '"'); 
    endpoint=${endpoint//*SPLUNK_ACCOUNT_TRIAL: /};
}

read_first_name() {
    firstName=$(grep MY_FIRST_NAME $secrets_file | tr -d '"'); 
    firstName=${firstName//*MY_FIRST_NAME: /};
}

read_last_name() {
    lastName=$(grep MY_LAST_NAME $secrets_file | tr -d '"'); 
    lastName=${lastName//*MY_LAST_NAME: /};
}

read_email() {
    email=$(grep MY_EMAIL $secrets_file | tr -d '"'); 
    email=${email//*MY_EMAIL: /};
}

read_org_name() {
    orgName=$(grep MY_ORG_NAME $secrets_file | tr -d '"'); 
    orgName=${orgName//*MY_ORG_NAME: /};
}

read_company_name() {
    companyName=$(grep MY_COMPANY_NAME $secrets_file | tr -d '"'); 
    companyName=${companyName//*MY_COMPANY_NAME: /};
}




if [ -f "$secrets_file" ]
then
  read_account_trial_endpoint
  read_email
  read_org_name
  read_company_name
  read_first_name
  read_last_name

  payload='{"firstName": "'"$firstName"'", "lastName": "'"$lastName"'", "email":"'"$email"'", "orgName": "'"$orgName"'", "companyName": "'"$companyName"'"}'
  echo $endpoint
#   echo $payload
  curl -X POST $endpoint -H "Content-Type: application/json" -d "$payload" -i
else
    echo "$secrets_file not found"
fi