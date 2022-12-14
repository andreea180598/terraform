data "azurerm_resource_group" "test" {
  name = "andreea-rg"
}

data "azurerm_public_ip" "test" {
  name                = azurerm_public_ip.test.name
  resource_group_name = data.azurerm_resource_group.test.name

  depends_on = [azurerm_public_ip.test]
}

data "azurerm_kubernetes_cluster" "test" {
  name                = azurerm_kubernetes_cluster.test.name
  resource_group_name = data.azurerm_resource_group.test.name

  depends_on = [azurerm_kubernetes_cluster.test]
}

