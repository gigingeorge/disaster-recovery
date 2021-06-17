#!/bin/bash 

terraform plan -detailed-exitcode

if [ $? -eq 0 ]; then
  echo "No changes, not applying"
  exit 1

elif [ $? -eq 1 ]; then
  echo "Terraform plan failed"
  exit 1

elif [ $? -eq 2 ]; then
  terraform apply -auto-approve
fi

if [   $? -eq 0 ];
   then
    ansible-playbook play.yml
    else
    echo  "Error in code"
fi
