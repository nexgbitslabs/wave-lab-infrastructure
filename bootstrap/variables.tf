# ============================================================
# Terraform Bootstrap Variables
# ============================================================

variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "location" {
  description = "Azure region used for Terraform state resources."
  type        = string
}

variable "environment" {
  description = "Environment identifier."
  type        = string
}

variable "project_name" {
  description = "Project identifier used in resource naming."
  type        = string
}

variable "tags" {
  description = "Common Azure resource tags."
  type        = map(string)
}