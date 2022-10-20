data "azurerm_resource_group" "andreea-rg" {
  name = "andreea-rg"
}

// data for public ip address which depends on the creation of public ip resource

data "azurerm_public_ip" "andreea_public_ip" {
  name                = azurerm_public_ip.andreea-public-ip.name
  resource_group_name = data.azurerm_resource_group.andreea-rg.name

  depends_on = [azurerm_public_ip.andreea-public-ip]
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = azurerm_kubernetes_cluster.aks-andreea.name
  resource_group_name = data.azurerm_resource_group.andreea-rg.name

  depends_on = [azurerm_kubernetes_cluster.aks-andreea]

}

