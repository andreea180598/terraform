resource "azurerm_resource_group" "aks-resource-andreea" {
  name     = "aks-resource-andreea"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks-andreea" {
  name                = "aks-andreea"
  location            = azurerm_resource_group.aks-resource-andreea.location
  resource_group_name = azurerm_resource_group.aks-resource-andreea.name
  dns_prefix          = "andreeaaks-dns-prefix"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "DEV"
  }
}