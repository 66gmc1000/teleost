#!/bin/bash

# ./destroy-teleost.sh --subscriptionid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --clientid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --clientsecret=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --tenantid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

for i in "$@"
do
    case $i in
        --subscriptionid=*)
            SUBSCRIPTIONID="${i#*=}"
            ;;
        --clientid=*)
            CLIENTID="${i#*=}"
            ;;
        --clientsecret=*)
            CLIENTSECRET="${i#*=}"
            ;;
        --tenantid=*)
            TENANTID="${i#*=}"
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

# check if terraform is installed or not
if [[ -z "$(type terraform --version)" ]]; then
  read -p "Terraform is not installed. Press [Enter] to install now..."
  sudo apt-get install unzip
  mkdir temp
  cd temp
  wget https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip
  unzip terraform_0.12.2_linux_amd64.zip
  sudo mv terraform /usr/local/bin/
  cd ..
  rm -rf temp
  terraform --version
fi

# # check if ansible is installed or not
# if [[ -z "$(sudo ansible-playbook)" ]]; then
#   read -p "Ansible is not installed. Press [Enter] to install now..."
#   sudo apt install software-properties-common
#   sudo apt-add-repository ppa:ansible/ansible -y
#   sudo apt update
#   sudo apt install ansible -y
# fi

terraform=$(which terraform)
# ansible=$(which ansible-playbook)

# ssh-keygen -t rsa -b 4096 -f ./ansible-key -N ''

$terraform init terraform
echo $terraform destroy -var subscription_id=${SUBSCRIPTIONID} -var client_id=${CLIENTID} -var client_secret=${CLIENTSECRET} -var tenant_id=${TENANTID} terraform 
$terraform destroy -var subscription_id=${SUBSCRIPTIONID} -var client_id=${CLIENTID} -var client_secret=${CLIENTSECRET} -var tenant_id=${TENANTID} terraform

echo "VPS, sshkey, firewall rules and all other associated resources have been destroyed"


