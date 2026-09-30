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
  description = "Resource Group containing the Log Analytics workspace."
  type        = string
}

variable "sku" {
  description = "Log Analytics workspace SKU."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Number of days Log Analytics data is retained."
  type        = number
  default     = 30

  validation {
    condition     = var.retention_in_days >= 30
    error_message = "Log Analytics retention must be at least 30 days."
  }
}

variable "tags" {
  description = "Common tags applied to the Log Analytics workspace."
  type        = map(string)
  default     = {}
}