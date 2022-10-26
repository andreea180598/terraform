resource "azurerm_resource_group" "test" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "test" {
  name                = "${var.acr_name}1898"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku_acr
  admin_enabled       = false
}

