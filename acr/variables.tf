variable "resource_group_name" {
  type        = string
  default     = "acr-andreea"
  description = "Resource Group name"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Region"
}

variable "sku_acr" {
  type        = string
  default     = "Basic"
  description = "acr sku"
}

variable "acr_name" {
  type        = string
  default     = "acrandreea"
  description = "ACR name"
}

