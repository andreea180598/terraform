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

variable "aks_name" {
  type        = string
  default     = "andreea-aks"
  description = "AKS name"
}

variable "node_number" {
  type        = number
  default     = 1
  description = "AKS nodes number"
}