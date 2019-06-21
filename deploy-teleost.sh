#!/bin/bash

# ./deploy-teleost.sh --app=test --environment=staging --num=2 --size=t2.micro

for i in "$@"
do
    case $i in
        --app=*)
            APP="${i#*=}"
            ;;
        --environment=*)
            ENVIRONMENT="${i#*=}"
            ;;
        --num=*)
            NUM="${i#*=}"
            ;;
        --size=*)
            SIZE="${i#*=}"
            ;;
        *)
            # unknown option
            ;;
    esac
done

# check if awscli installed or not
if [[ -z "$(type az)" ]]; then
  read -p "Azure CLI is not installed. Installing and logging in Press [Enter]..."
  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash 
  az login --allow-no-subscriptions
elif [[ -z "$(az account list | grep 'AzureCloud')" ]]; then
  # login if not yet logged
  echo "Not logged in to Azure"
  read -p "Press [Enter] to login now..." 
  az login --allow-no-subscriptions
fi

# terraform=$(which terraform)
# ansible=$(which ansible-playbook)

# ssh-keygen -t rsa -b 4096 -f ./ansible-key -N ''

# echo $terraform apply -var app_name=${APP} -var environment=${ENVIRONMENT} -var num_servers=${NUM} -var instance_type=${SIZE} terraform 
# $terraform apply -var app_name=${APP} -var environment=${ENVIRONMENT} -var num_servers=${NUM} -var instance_type=${SIZE} -var ssh_key="$(cat ./ansible-key.pub)" terraform

# echo '[wordpress]' > ansible/inventory

# $terraform output public_ip | sed -e 's/,$//' >> ansible/inventory


# echo $ansible -i ansible/inventory --key-file="./ansible-key" ansible/site.yml
# $ansible -i ansible/inventory --key-file="./ansible-key" ansible/site.yml 

# echo "Connect to wordpress app using below ELB DNS Name"
# echo "ELB DNS might take few minutes to be available"

# $terraform output elb_dns_name




