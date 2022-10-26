variable "resource_group_name" {
  type        = string
  default     = "andreea-rg"
  description = "Resource Group name"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Region"
}

variable "mysql_server_name" {
  type        = string
  default     = "mysql-server-andreea"
  description = "Mysql server name"
}

variable "server_admin_username" {
  type        = string
  default     = "andreea"
  description = "Mysql server admin username"
}

variable "server_admin_password" {
  type        = string
  default     = "mysql-server-andreea"
  description = "Mysql server admin password"
}
