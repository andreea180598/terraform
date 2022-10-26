// AKS vars
variable "aks_name" {
  type        = string
  default     = "aks-andreea"
  description = "aks name"
}

variable "aks_dns_prefix" {
  type        = string
  default     = "aks-prefix-andreea"
  description = "AKS DNS prefix"
}

variable "aks_vm_size" {
  type        = string
  default     = "Standard_B2s"
  description = "AKS vm sku"
}

variable "aks_nodes_number" {
  type        = number
  default     = 1
  description = "AKS nodes number"
}


//ACR vars
variable "sku_acr" {
  type        = string
  default     = "Basic"
  description = "ACR sku"
}

variable "acr_name" {
  type        = string
  default     = "acrandreea1898"
  description = "ACR name"
}


// MYSQL + FW vars

variable "mysql_server_name" {
  type        = string
  default     = "andreeadb"
  description = "MySQL Server name"
}


variable "mysql_admin_username" {
  type      = string
  sensitive = true
}

variable "mysql_admin_password" {
  type      = string
  sensitive = true
}

variable "mysql_ip_address" {
  type        = string
  default     = "188.26.140.143"
  description = "MySQL Server ip address"
  sensitive   = true
}


//vars for creating or not resources

variable "create-DB-server" {
  type        = bool
  default     = false
  description = "if true create mysql DB server"
}

variable "create-DB" {
  type        = bool
  default     = false
  description = "if true create mysql DB"
}

variable "create-DB-firewall" {
  type        = bool
  default     = false
  description = "if true create firewall rule"
}

variable "create-public-ip" {
  type        = bool
  default     = true
  description = "if true create public ip"
}

variable "create-DNS-zone" {
  type        = bool
  default     = true
  description = "if true create DNS zone"
}

variable "create-A-record" {
  type        = bool
  default     = false
  description = "if true create A record DNS rule"
}

variable "create-manifest" {
  type        = bool
  default     = true
  description = "if true create nginx ingress"
}