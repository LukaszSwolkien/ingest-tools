#!/bin/bash
secrets_file=".secrets.yaml"

read_account_trial_endpoint() {
    endpoint=$(grep splunk-account-trial $secrets_file | tr -d '"'); 
    endpoint=${endpoint//*splunk-account-trial: /};
}

read_first_name() {
    firstName=$(grep my-first-name $secrets_file | tr -d '"'); 
    firstName=${firstName//*my-first-name: /};
}

read_last_name() {
    lastName=$(grep my-last-name $secrets_file | tr -d '"'); 
    lastName=${lastName//*my-last-name: /};
}

read_email() {
    email=$(grep my-email $secrets_file | tr -d '"'); 
    email=${email//*my-email: /};
}

read_org_name() {
    orgName=$(grep my-org-name $secrets_file | tr -d '"'); 
    orgName=${orgName//*my-org-name: /};
}

read_company_name() {
    companyName=$(grep my-company-name $secrets_file | tr -d '"'); 
    companyName=${companyName//*my-company-name: /};
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
