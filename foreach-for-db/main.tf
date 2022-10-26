resource "azurerm_resource_group" "test" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_mysql_server" "test" {
  name                = var.mysql_server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.server_admin_username
  administrator_login_password = var.server_admin_password

  sku_name   = "B_Gen5_1"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = false
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "test" {
  for_each = {
    "db1" = { resource_group_name = "andreea", server = "mysql-server-andreea" }
    "db2" = { resource_group_name = "andreea", server = "mysql-server-andreea" }
  }
  name                = each.key
  resource_group_name = each.value.resource_group_name
  server_name         = each.value.server
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
  depends_on          = [azurerm_resource_group.test, azurerm_mysql_server.test]
}


resource "azurerm_mysql_firewall_rule" "test" {
  name                = "mysql-fwr-andreea"
  resource_group_name = var.resource_group_name
  server_name         = var.mysql_server_name
  start_ip_address    = "188.27.84.135"
  end_ip_address      = "188.27.84.135"
}
