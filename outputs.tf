output "id" {
  description = "The ID of the Subnet."
  value       = azurerm_subnet.subnet.id
}

output "name" {
  description = "The Name of the Subnet."
  value       = azurerm_subnet.subnet.name
}

output "resource_group_name" {
  description = "The Resource Group Name of the Subnet."
  value       = azurerm_subnet.subnet.resource_group_name
}

output "virtual_network_name" {
  description = "The Virtual Network Name of the Subnet."
  value       = azurerm_subnet.subnet.virtual_network_name
}

output "address_prefixes" {
  description = "The address prefixes assigned to the Subnet."
  value       = azurerm_subnet.subnet.address_prefixes
}
