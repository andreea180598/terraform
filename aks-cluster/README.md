Connect to AKS using Azure CLI:

`az aks get-credentials --resource-group name_of_rg  --name aks_name`

Integrate AKS cluster with ACR:

`az aks update -n aks_name -g resource_group_name --attach-acr acr_name`