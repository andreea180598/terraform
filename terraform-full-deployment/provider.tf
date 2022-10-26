terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.26.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.14.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "andreea-rg"
    storage_account_name = "storageandreea18"
    container_name       = "tfstate"
    key                  = "tfstate"
    access_key           = "kYo0MGIus0rwEZtuKY4Thzwd/2iSe3bu5QpzYymR+dwSw6UWQVqHVEG2i1patIikXrg86yzMDNWc+AStNINfnQ=="
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "helm" {
  debug = true
  kubernetes {
  host                   = data.azurerm_kubernetes_cluster.test.kube_config[0].host
  client_key             = base64decode(data.azurerm_kubernetes_cluster.test.kube_config[0].client_key)
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.test.kube_config[0].client_certificate)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.test.kube_config[0].cluster_ca_certificate)
  }
}

provider "kubernetes" {

  host                   = data.azurerm_kubernetes_cluster.test.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.test.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.test.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.test.kube_config.0.cluster_ca_certificate)
}