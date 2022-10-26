Connect to ACR using Azure CLI:

`az acr login --name name_of_acr`

Integrate AKS cluster with ACR:

`az aks update -n aks_name -g resource_group_name --attach-acr acr_name`