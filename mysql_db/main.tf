resource "azurerm_resource_group" "mysql-resource" {
  name     = "mysql-resource-andreea"
  location = "East US"
}

resource "azurerm_mysql_server" "mysql-server" {
  name                = "mysql-server-andreea"
  location            = azurerm_resource_group.mysql-resource.location
  resource_group_name = azurerm_resource_group.mysql-resource.name

  administrator_login          = "andreea"
  administrator_login_password = "1234qwer!"

  sku_name   = "B_Gen5_1"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = false
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_0"
}

resource "azurerm_mysql_database" "mysql-db" {
  name                = "mysql-db-andreea"
  resource_group_name = azurerm_resource_group.mysql-resource.name
  server_name         = azurerm_mysql_server.mysql-server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}


resource "azurerm_mysql_firewall_rule" "mysql-fwr" {
  name                = "mysql-fwr-andreea"
  resource_group_name = azurerm_resource_group.mysql-resource.name
  server_name         = azurerm_mysql_server.mysql-server.name
  start_ip_address    = "188.26.140.143"
  end_ip_address      = "188.26.140.143"
}
