**"terraform-full-deployment"** script contains the following resources:
 - Azure kubernetes cluster with:
    - Nginx Ingress Controller (using Helm)
    - Cert manager (using Helm)
    - Deployment of an Ingress example (using Kubernetes)
 - Azure continer registry
 - Mysql Server
 - Mysql DB
 - Firewall Rule for DB
 - Public ip
 - DNS zone
 - DNS A Record

Connect to AKS using Azure CLI:

`az aks get-credentials --resource-group name_of_rg  --name aks_name`

Connect to ACR using Azure CLI:

`az acr login --name name_of_acr`

Integrate AKS cluster with ACR:

`az aks update -n aks_name -g resource_group_name --attach-acr acr_name`

Connect to Mysql Server using Azure CLI:

`mysql -h mysql_server_name.mysql.database.azure.com -u username@mysql_server_name -p`

To use an existing Mysql database:

`USE db_name;`


  