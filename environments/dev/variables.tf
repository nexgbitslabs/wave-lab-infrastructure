# ============================================================
# Azure
# ============================================================

variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID."
  type        = string
}

variable "location" {
  description = "Azure deployment region."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition = contains(
      ["dev", "qa", "uat", "prod"],
      var.environment
    )
    error_message = "Environment must be dev, qa, uat, or prod."
  }
}

variable "project_name" {
  description = "Project identifier used for resource naming."
  type        = string
}

# ============================================================
# Networking
# ============================================================

variable "vnet_address_space" {
  description = "Address space assigned to the virtual network."
  type        = list(string)
}

variable "aks_subnet_address_prefixes" {
  description = "Address prefixes assigned to the AKS subnet."
  type        = list(string)
}

variable "private_endpoint_subnet_address_prefixes" {
  description = "Address prefixes assigned to the private endpoint subnet."
  type        = list(string)
}

# ============================================================
# AKS
# ============================================================

variable "aks_system_node_vm_size" {
  description = "VM size for the AKS system node pool."
  type        = string
}

variable "aks_system_node_count" {
  description = "Number of AKS system nodes."
  type        = number
}

variable "aks_user_node_vm_size" {
  description = "VM size for the AKS user node pool."
  type        = string
}

variable "aks_user_node_count" {
  description = "Number of AKS user nodes."
  type        = number
}

# ============================================================
# ACR
# ============================================================

variable "acr_sku" {
  description = "Azure Container Registry SKU."
  type        = string
}

# ============================================================
# Key Vault
# ============================================================

variable "key_vault_sku" {
  description = "Azure Key Vault SKU."
  type        = string
}

# ============================================================
# Tags
# ============================================================

variable "tags" {
  description = "Common Azure resource tags."
  type        = map(string)
  default     = {}
}

# ============================================================
# Flux / GitOps
# ============================================================

variable "flux_git_repository_url" {
  description = "Git repository used by Flux for GitOps reconciliation."
  type        = string
}

variable "flux_git_branch" {
  description = "Git branch used by Flux."
  type        = string
  default     = "main"
}

variable "flux_git_path" {
  description = "Path within the GitOps repository reconciled by Flux."
  type        = string
  default     = "clusters/dev"
}