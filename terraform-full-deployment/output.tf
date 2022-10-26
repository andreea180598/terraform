# output "location" {
#   value = data.azurerm_resource_group.andreea-rg.location
# }


output "public_ip" {
  value = data.azurerm_public_ip.test.id
}
