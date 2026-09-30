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
  description = "Resource Group containing Azure Container Registry."
  type        = string
}

variable "sku" {
  description = "Azure Container Registry SKU."
  type        = string
  default     = "Premium"

  validation {
    condition = contains(
      ["Basic", "Standard", "Premium"],
      var.sku
    )

    error_message = "ACR SKU must be Basic, Standard, or Premium."
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access to ACR is enabled."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags applied to Azure Container Registry."
  type        = map(string)
  default     = {}
}