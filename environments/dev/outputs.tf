# ============================================================
# Resource Group
# ============================================================

output "resource_group_name" {
  description = "DEV Azure Resource Group."
  value       = module.resource_group.name
}

# ============================================================
# Networking
# ============================================================

output "vnet_name" {
  description = "DEV Virtual Network name."
  value       = module.networking.vnet_name
}

output "aks_subnet_id" {
  description = "AKS subnet resource ID."
  value       = module.networking.aks_subnet_id
}

output "private_endpoint_subnet_id" {
  description = "Private endpoint subnet resource ID."
  value       = module.networking.private_endpoint_subnet_id
}

# ============================================================
# Log Analytics
# ============================================================

output "log_analytics_workspace_name" {
  description = "Log Analytics workspace name."
  value       = module.log_analytics.name
}

# ============================================================
# Azure Container Registry
# ============================================================

output "acr_name" {
  description = "Azure Container Registry name."
  value       = module.acr.name
}

output "acr_login_server" {
  description = "Azure Container Registry login server."
  value       = module.acr.login_server
}

# ============================================================
# Key Vault
# ============================================================

output "key_vault_name" {
  description = "Azure Key Vault name."
  value       = module.key_vault.name
}

output "key_vault_uri" {
  description = "Azure Key Vault URI."
  value       = module.key_vault.vault_uri
}

# ============================================================
# AKS
# ============================================================

output "aks_name" {
  description = "AKS cluster name."
  value       = module.aks.name
}

output "aks_fqdn" {
  description = "AKS API server FQDN."
  value       = module.aks.fqdn
}

output "aks_node_resource_group" {
  description = "Azure-managed AKS node Resource Group."
  value       = module.aks.node_resource_group
}

output "aks_oidc_issuer_url" {
  description = "AKS OIDC issuer URL."
  value       = module.aks.oidc_issuer_url
}

# ============================================================
# Flux / GitOps
# ============================================================

output "flux_extension_id" {
  description = "Flux v2 AKS extension resource ID."
  value       = module.flux.extension_id
}

output "flux_configuration_id" {
  description = "Flux GitOps configuration resource ID."
  value       = module.flux.configuration_id
}