#!/bin/bash
secrets_file=".secrets.yaml"

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
  read_email
  read_org_name
  read_company_name
  read_first_name
  read_last_name

  lab0-sfc org cre -e $email -ln $lastName -fn $firstName -on $orgName

else
    echo "$secrets_file not found"
fi
