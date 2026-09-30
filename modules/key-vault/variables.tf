# ============================================================
# General
# ============================================================

variable "project_name" {
  description = "Project identifier used in resource naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment such as dev, qa, uat, or prod."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group containing the Key Vault."
  type        = string
}

# ============================================================
# Key Vault
# ============================================================

variable "sku_name" {
  description = "Azure Key Vault SKU."
  type        = string
  default     = "standard"

  validation {
    condition = contains(
      ["standard", "premium"],
      lower(var.sku_name)
    )

    error_message = "Key Vault SKU must be standard or premium."
  }
}

variable "soft_delete_retention_days" {
  description = "Number of days deleted Key Vault objects are retained."
  type        = number
  default     = 30

  validation {
    condition = (
      var.soft_delete_retention_days >= 7 &&
      var.soft_delete_retention_days <= 90
    )

    error_message = "Soft delete retention must be between 7 and 90 days."
  }
}

variable "purge_protection_enabled" {
  description = "Whether purge protection is enabled for the Key Vault."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access to Key Vault is enabled."
  type        = bool
  default     = true
}

# ============================================================
# Tags
# ============================================================

variable "tags" {
  description = "Common tags applied to the Key Vault."
  type        = map(string)
  default     = {}
}