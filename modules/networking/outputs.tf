output "vnet_id" {
  description = "Virtual Network resource ID."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Virtual Network name."
  value       = azurerm_virtual_network.this.name
}

output "aks_subnet_id" {
  description = "AKS subnet resource ID."
  value       = azurerm_subnet.aks.id
}

output "aks_subnet_name" {
  description = "AKS subnet name."
  value       = azurerm_subnet.aks.name
}

output "private_endpoint_subnet_id" {
  description = "Private endpoint subnet resource ID."
  value       = azurerm_subnet.private_endpoints.id
}

output "private_endpoint_subnet_name" {
  description = "Private endpoint subnet name."
  value       = azurerm_subnet.private_endpoints.name
}