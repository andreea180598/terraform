terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.26.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "acr-andreea"
    storage_account_name = "storageandreea1898"
    container_name       = "mycontainer"
    key                  = "mykey"
    access_key           = "bczTf0tFn39jj1ZAn5mYPSbrBF/YdSXfi/DnwVtUvJ7UuzyQWLjrdNXFh7XXIdSB/88uB+8nCTN9+AStcu8aNQ=="
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}