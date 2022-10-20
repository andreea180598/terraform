// AKS resource
resource "azurerm_kubernetes_cluster" "aks-andreea" {
  //count               = var.create-aks ? 1 : 0
  name                = var.aks_name
  location            = data.azurerm_resource_group.andreea-rg.location
  resource_group_name = data.azurerm_resource_group.andreea-rg.name
  dns_prefix          = var.aks_dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.aks_nodes_number
    vm_size    = var.aks_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "DEV"
  }
}

// ACR resource
resource "azurerm_container_registry" "acr-andreea" {
  count               = var.create-acr ? 1 : 0
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.andreea-rg.name
  location            = data.azurerm_resource_group.andreea-rg.location
  sku                 = var.sku_acr
  admin_enabled       = false
}


// MySQL Server resource

resource "azurerm_mysql_server" "mysql-server" {
  count               = var.create-DB-server ? 1 : 0
  name                = "mysql-server-andreea"
  location            = data.azurerm_resource_group.andreea-rg.location
  resource_group_name = data.azurerm_resource_group.andreea-rg.name

  administrator_login          = var.mysql_admin_username
  administrator_login_password = var.mysql_admin_password

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

// mysql DB resource

resource "azurerm_mysql_database" "mysql-db" {
  count               = var.create-DB ? 1 : 0
  name                = "mysql-db-andreea"
  resource_group_name = data.azurerm_resource_group.andreea-rg.name
  server_name         = var.mysql_server_name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

//FW rule for DB

resource "azurerm_mysql_firewall_rule" "mysql-fwr" {
  count               = var.create-DB-firewall ? 1 : 0
  name                = "mysql-fwr-andreea"
  resource_group_name = data.azurerm_resource_group.andreea-rg.name
  server_name         = var.mysql_server_name
  start_ip_address    = var.mysql_ip_address
  end_ip_address      = var.mysql_ip_address
}


// public ip resource

resource "azurerm_public_ip" "andreea-public-ip" {
  name                = "andreea-public-ip"
  resource_group_name = data.azurerm_resource_group.andreea-rg.name
  location            = data.azurerm_resource_group.andreea-rg.location
  allocation_method   = "Static"
}

// DNS Zone resource

resource "azurerm_dns_zone" "andreea-dns" {
  name                = "andreea.com"
  resource_group_name = data.azurerm_resource_group.andreea-rg.name
}

// DNS A record resource which depends on the creation of ip_address data

resource "azurerm_dns_a_record" "andreea-A-record" {
  name                = "andreea-A-record"
  zone_name           = azurerm_dns_zone.andreea-dns.name
  resource_group_name = data.azurerm_resource_group.andreea-rg.name
  ttl                 = 300
  target_resource_id  = data.azurerm_public_ip.andreea_public_ip.id
  depends_on = [
    data.azurerm_public_ip.andreea_public_ip
  ]
}

// Helm - install ingress controller- resource

resource "helm_release" "ingress" {
  depends_on       = [data.azurerm_kubernetes_cluster.aks]
  name             = "andreea-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = "ingress-ns"
  create_namespace = true
}

// Helm - install cert-manager- resource

resource "helm_release" "cert_manager" {
  depends_on       = [data.azurerm_kubernetes_cluster.aks]
  name             = "cert-manager-andreea"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.7.1"
  namespace        = "cert-manager-ns"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}



// Kubernetes provider - manifest for ingress

resource "kubernetes_manifest" "test-ingress" {
  count = var.create-A-record ? 1 : 0 
  depends_on = [data.azurerm_kubernetes_cluster.aks , helm_release.ingress] 
  manifest  = yamldecode(file("createIngress.yml"))
}
