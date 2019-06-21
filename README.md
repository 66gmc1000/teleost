# teleost
                                                                                                              
                                                                                                              
                                                     -:                                                       
                                                   .o.                                                        
                                                 `/ys`                                                        
                    ```                         .syyyo.                                                       
                `-::---::-`                    :syyyyys/`                                                     
              `-:.      ``:/.                 /syyyyyyyyso/-````.--`                                          
             ./.           `/:`              /syyyyyyyyyyhyyssoss:                                            
            :-               :+-            :syyyyyyyyyyyyyyyyyyy+`                                           
           :-                 .o:          .syyyyyyyyyyyyyysyyyyyys/.`                                    `.::
          --                   `++`        osyyyyyyyyyyyyssyyyyyyyyyyso/:--::-.                        .:+so. 
         .:                      +o.      -ssyyyyyyyyyyyssyyyyyyyyyyyyyyyyyhy                       .:osyy+`  
        `/                        /o-     ossysyyyyyyyyysyyyyyyyyyyyyyyyyyhhh:                    -oyyyyyy.   
        :-                         /s:``.-oosssyyyyyyyyssyyyyyyyyyyyyyyyyyyhhho-`               -oyyyyyyyy:   
       `o`                       `  +sossyo+sosysyysyysssssssssssyyyyyyyyyyhhhhhso/--..```    `+yyyyyyyyyys:` 
       /o                   .::///::/yysosssssssssyssssssysyssssossssssossossssysyys/..`     -yhyyyyyyyyyyyso:
      .o+                 `+ooo+//::/oosoyysyysossyssosssysssssossssssssoooooooooy/`       `+hhhhyyyyyyysssss:
     `+oo                `ysso+/////oooooyyssyyssssssossyysssssssssssssooooossoooooo+/-.``.shhhhhyyyyssyyyss: 
     ++os-               /dsso+++++oooooosyyoyysyssssssssssssssssssosssossooooooooosssoooosyyyyhyyyyyyyyyyys  
    `+os+:            `.:+dysyoooosossss+sssossossssssssyyyssssysssosssoooooosoossyysssoooooooossyyyyyyyyyy+  
     -+o:`          -+oyyyhhyyysssssssyyosysoyysyyssooosssssosssssssosoosoooossoooooooooossooossssyyyyyyyyso  
      .:`          /Mhhsyyyyhhhyyhhhyhhsyoyssosshhysos+soooooso+++osoosssssososyssssssssoooosssyyyyyyyyyyyys- 
                  ..Nmssssyyhyhdhhdhhsssyssso+ossyssosooooooooo++o+ossooosossosssssssossssssyyhhhysssssssssss-
                  .:ssoosssyhhyhhyyyyyoyssooo+ssosoooo+o++o+/++++++osooooosyysssososyyyysyyhddysssyssyyyyyss+:
               .:+oososyyhyysyyyyhyyyyysys+ssoossyooo++oo++////+++ossssosssssssssssyyyyhhddmhyyyyyyyssssso-   
            `:/+s+:/osssyyhyhshysyysyhyyssooososoyooo+o+/++o+//+osooosoossssssyssyyyyyhddssyyysyyyyyysys-     
          `...-..-+ooossshyyssyyhsyysooosysosoooososs+//+/++++oosssssyyyyyyyyyyyyyhhhdh+`      ./oyyyys.      
         .   `----``` `+ssyysysyshyhsoossossoo+osyoso/+++oosyyyyyyyyyyyyyyyyyyyhhhddy:            `:+s:       
      `    `..   ``  .-../syysysyysshhyosoo++oooosos+/+oyyyyssyyhhhyyyhyhyhhyhdhddy-                 `-`      
  `   .   .      ..``    `:ossssssysoyhyssso+osoysssssyyyyyhhhhhhhhhdhhhhhhddhhdy-                            
. .`` `-  .`     .-   ``..``-oysossysoyysoyss+ooosyydhyhhhhhhhhhhhhhhhhhhhhhhhhy-                             
s- -.` --  -`    -/``.` .    -/ysooossossysysoosossydhhhhhhyhhyhyyyyyyyyyyyyyo++//:---.`                      
-s/-/-` /:``:`  `:+. .  .`  .-.-ohsosssosssosyosooosmdhddhhhhhhhhyyyhyyyhhdo`       ```..                     
 -ooo+/sso+/++++o+oo+//-:--::.  .-yyssosooosoooyssoodddddddddddhdhdhhhhhdh:                                   
 .oo+ooyhyyssssoosssoooooo++++/::-/hsososossssosysosyddhhhhhhhhdddddddhds`                                    
`yyhsooshyyyyyysssyyyyyyyyyyyysossooyhysooossssossssyddddhhhhhyyhhhhhddo                                      
`syyyyysssyssyyyssssssyyysyyyyysyssysydyyssosssssyyysyhddmddhhhhhhyhhy+/:-.                                   
 /dhyyyhsossysyyoyyysyyyssyyyyyyyhyyyyhhyssooosyssyyysyyhddmdddhhhdds`  ``.-`                                 
  smdhysyyyssyoosyssyyyyssyyyyyysyyyhhhdyysssossssyyyyssyhhddmmhddd/                                          
  `oddhhyyyyyysssyoosyyyssyyyyyysyyyyyyhhyyyysssssyhhhysyhhhhdddds.                                           
    -yddddhhyssssyysosoosssyyyyyyyyyyhhhhyyyyyssyyyyhhyyhhhhdddy+`                                            
     `/hdddddhhyyyyyossossssyyyyyyyyyyyyyysyyyyyhyyyhhhhhddddh/`.-`                                           
       ./ydddddddhhhyyyyssssosssssssssssyyyyyyhyyyyyhhhhddmh/`    `                                           
         `-ohdddddddddddhhhhysyssyyyssyyyyyhhhyyyhhhhddddy:`                                                  
            `:shddddddddddddddddddhhhhhhhhhhhhhhhddddmho-                                                     
               `-+yhdddddddddddddddddddddddddddddddhs:`                                                       
                   .:+shhhdddddddddddddddddmmddhs+:`                                                          
                        `.-:/+oossyyyyhysoo+:-.                                                               
                                                                                                              
                                                                                                              
                                                                                                                 
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
- A debian based machine with sudo privileges to execute the deployment from

To Deploy:
- Clone image: `git clone https://github.com/66gmc1000/teleost.git`
- Switch to the repo root directory: `cd teleost`
- Execute `./deploy-teleost.sh` and the required parameters on the command line in the format below:

`./deploy-teleost.sh --app=teleost --environment=play --size=Standard_DS1_v2 --region=eastus --hostname=teleost --subscriptionid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --clientid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --clientsecret=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx --tenantid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`

- Visit http://IPADDRESS/wp-admin to configure your newly install Wordpress instance

Defaults (can be edited via ansible/roles/deploy/tasks/main.yml):

- MYSQL_ROOT_PASSWORD: wordpress
- MYSQL_DATABASE: wordpress
- MYSQL_USER: wordpress
- MYSQL_PASSWORD: wordpress
