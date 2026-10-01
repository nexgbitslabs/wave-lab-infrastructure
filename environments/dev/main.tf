# ============================================================
# Naming
# ============================================================

locals {
  resource_group_name = "rg-${var.project_name}-${var.environment}"

  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = var.project_name
    }
  )
}

# ============================================================
# Resource Group
# ============================================================

module "resource_group" {
  source = "../../modules/resource-group"

  name     = local.resource_group_name
  location = var.location

  tags = local.common_tags
}

# ============================================================
# Networking
# ============================================================

module "networking" {
  source = "../../modules/networking"

  project_name        = var.project_name
  environment         = var.environment
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  vnet_address_space                       = var.vnet_address_space
  aks_subnet_address_prefixes              = var.aks_subnet_address_prefixes
  private_endpoint_subnet_address_prefixes = var.private_endpoint_subnet_address_prefixes

  tags = local.common_tags
}

# ============================================================
# Log Analytics
# ============================================================

module "log_analytics" {
  source = "../../modules/log-analytics"

  project_name        = var.project_name
  environment         = var.environment
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  tags = local.common_tags
}

# ============================================================
# Azure Container Registry
# ============================================================

module "acr" {
  source = "../../modules/acr"

  project_name        = var.project_name
  environment         = var.environment
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  sku = var.acr_sku

  tags = local.common_tags
}

# ============================================================
# Key Vault
# ============================================================

module "key_vault" {
  source = "../../modules/key-vault"

  project_name        = var.project_name
  environment         = var.environment
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  sku_name = var.key_vault_sku

  tags = local.common_tags
}

# ============================================================
# Azure Kubernetes Service
# ============================================================

module "aks" {
  source = "../../modules/aks"

  project_name        = var.project_name
  environment         = var.environment
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tenant_id           = var.tenant_id

  aks_subnet_id              = module.networking.aks_subnet_id
  log_analytics_workspace_id = module.log_analytics.id

  system_node_vm_size = var.aks_system_node_vm_size
  system_node_count   = var.aks_system_node_count

  user_node_vm_size = var.aks_user_node_vm_size
  user_node_count   = var.aks_user_node_count

  tags = local.common_tags
}

# ============================================================
# AKS -> ACR
# ============================================================

module "aks_acr_pull" {
  source = "../../modules/role-assignments"

  scope                = module.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity_object_id
  principal_type       = "ServicePrincipal"
}

# ============================================================
# Flux v2 / GitOps
# ============================================================

module "flux" {
  source = "../../modules/flux"

  cluster_id = module.aks.id

  extension_name     = "flux"
  configuration_name = "${var.project_name}-${var.environment}-gitops"

  namespace = "flux-system"

  git_repository_url = var.flux_git_repository_url
  git_branch         = var.flux_git_branch
  git_path           = var.flux_git_path
}