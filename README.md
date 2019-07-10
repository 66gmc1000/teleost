# teleost
                                                                                                    
                  `                                                             
               `.```.`                                                          
              ..     `.`                         `-                             
          ```-`        ..                       -o-`  `                         
        `.:sh.`         `.`                   .osssooo.  `                .-    
       `:hNMM-.           ..  ``.....``     `/ssssyyysooo:` ``          -+.     
      `.sMMMM:.           `-:::://///:::-.`-+//+syysssyyssoo+.  .     -oso      
       `-shh+.`         `-:///////::::////:/:::+o/+oyysssyyssoo/-   -osss+..    
        `````        `//:////////::::::::://////::/o+/+syyssss/`  -osssyyo.`    
                    :hNo///:::://:::///::::::://////:/o+/+os+. `:ossyyyys/      
                  -sho-:///.` `-//::///////:::::////////:/+- `:osyyyyssss:      
                `:/-` .////`   `///:////////////+ossyo+///:.-oyyyysssssss:      
       :        `  `-oy+///:.``-//::///////+ossyyyyyy+////////oyyyyyyyyyy/---.  
       /:          `.` -/////:://:::///////hhhhyyyyyyo//////::oyyssssssss-      
       .d` `          -///////:::::////////+++oooossss++++://::/+osssssss.      
        m+ .:          :////:::::////////////::::::::/:::.`.:///:::/+osss-      
        yN` d.  /      ://////////////////////////::::::/:.`  .-///::::/+---`   
        /Ms yh` m`     :////////////////////////:::::++/////:.`  `-:///::   .   
        `os.+No`M+ .   ://///////////////////::::://::/+++//::--`    .://`      
         .:///+:yy`o:  ://///////////////::::::::/+++//::///:`  `       ..--    
          -://////:/+-.://////////////::::::::++//:::+++/-   `             ``   
           .-::::///////////////::::::::::-//::/+++//:-`.-.                     
             .-::::::::::::::::::::::::-.` `-///:::/::.                         
               `.--::::::::::::::::--.`       `-//.   .                         
                  ``..---------...``             `--                            
                                                                                
                                                                                
                                                                                
        _______ _______        _______  _____  _______ _______
           |    |______ |      |______ |     | |______    |   
           |    |______ |_____ |______ |_____| ______|    |   
                                                       
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
- Security minded design choices


Prereqs:
- Valid Azure subscription
- subscription_id
- client_id
- client_secret
- tenant_id

To Deploy:
- Clone image: `git clone https://github.com/66gmc1000/teleost.git`
- Switch to the repo root directory: `cd teleost`
- Execute `./deploy-teleost.sh` with required parameters:

`./deploy-teleost.sh --app=teleost --environment=play --size=Standard_DS1_v2 --region=eastus --hostname=teleost --subscriptionid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --clientid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --clientsecret=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --tenantid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`

- Visit http://IPADDRESS/wp-admin to configure your newly install Wordpress instance

To Destroy:
- Switch to the repo root directory: `cd teleost`
- Execute `./destroy-teleost.sh` with required parameters:

`./destroy-teleost.sh --subscriptionid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx \
--clientid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx \
--clientsecret=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx \
--tenantid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`

Defaults (can be edited via ansible/roles/deploy/tasks/main.yml):

- MYSQL_ROOT_PASSWORD: wordpress
- MYSQL_DATABASE: wordpress
- MYSQL_USER: wordpress
- MYSQL_PASSWORD: wordpress
