# teleost
Quickly deploy a containerized Wordpress/MariaDB instance in azure

Note: This script works on debian distros only at this point (planned feature)

Features:
- Ubuntu 16.04 Server base image
- Latest MariaDB and Wordpress stable releases
- Terraform provisioning of Azure VM and associated resources
- Ansible configuration of VM:
    - nginx reverse proxy
    - docker-engine
    - mariadb and wordpress linked containers
    - persistant wordpress and mariadb storage
- Automated installation of required provisioning tools
- Supports customization of resource naming scheme <APPNAME>-<ENVIRONMENT>
- Security mindful design - sshkey auth, no exposed database ports, reverse proxy configuration


Prereqs:
- You will need the following from your Azure subscription (along with a valid subscription to AZ of course):
    - subscription_id
    - client_id
    - client_secret
    - tenant_id

To Deploy:
- Clone image: git clone https://github.com/66gmc1000/teleost.git
- Switch to the repo root directory: cd teleost
- Execute ./deploy-teleost.sh and the required parameters on the command line in the format below:

./deploy-teleost.sh --app=teleost --environment=play --size=Standard_DS1_v2 --region=eastus --hostname=teleost --subscriptionid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --clientid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --clientsecret=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --tenantid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx


Defaults:

- MYSQL_ROOT_PASSWORD = password
- MYSQL_DATABASE = wordpress
