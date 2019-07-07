#!/bin/bash

# ./deploy-teleost-vultr.sh --app=teleost --environment=play --size=Standard_DS1_v2 --region=eastus --hostname=teleost --subscriptionid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --clientid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --clientsecret=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --tenantid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

for i in "$@"
do
    case $i in
        --app=*)
            APP="${i#*=}"
            ;;
        --environment=*)
            ENVIRONMENT="${i#*=}"
            ;;
        --size=*)
            SIZE="${i#*=}"
            ;;
        --region=*)
            REGION="${i#*=}"
            ;;
        --hostname=*)
            HOSTNAME="${i#*=}"
            ;;
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

# check if Azure cli installed or not
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

# check if ansible is installed or not
if [[ -z "$(sudo ansible-playbook)" ]]; then
  read -p "Ansible is not installed. Press [Enter] to install now..."
  sudo apt install software-properties-common
  sudo apt-add-repository ppa:ansible/ansible -y
  sudo apt update
  sudo apt install ansible -y
fi

terraform=$(which terraform)
ansible=$(which ansible-playbook)

ssh-keygen -t rsa -b 4096 -f ./ansible-key -N ''

$terraform init terraform
$terraform apply \
-var app_name=${APP} \
-var environment=${ENVIRONMENT} \
-var instance_type=${SIZE} \
-var region=${REGION} \
-var hostname=${HOSTNAME} \
-var subscription_id=${SUBSCRIPTIONID} \
-var client_id=${CLIENTID} \
-var client_secret=${CLIENTSECRET} \
-var tenant_id=${TENANTID} \
-var ssh_key="$(cat ./ansible-key.pub)" \
terraform


# create wordpress line in ansible inventory
echo '[wordpress]' > ansible/inventory

# create IP entry for wordpress server in ansible inventory
az vm show \
--resource-group ${APP}-${ENVIRONMENT}-ResourceGroup \
--name ${APP}-${ENVIRONMENT}-VM \
-d --query [publicIps] --o tsv | sed -e 's/,$//' >> ansible/inventory


# run the ansible job against the VPS
sudo $ansible -i ansible/inventory --key-file="./ansible-key" ansible/site.yml 

# echo out ip address to connect to
echo "Connect to wordpress app using the IP address below"
az vm show \
--resource-group ${APP}-${ENVIRONMENT}-ResourceGroup \
--name ${APP}-${ENVIRONMENT}-VM \
-d --query [publicIps] --o tsv


