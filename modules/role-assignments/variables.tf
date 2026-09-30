variable "scope" {
  description = "Azure resource ID defining the scope of the role assignment."
  type        = string
}

variable "role_definition_name" {
  description = "Built-in Azure RBAC role to assign."
  type        = string
}

variable "principal_id" {
  description = "Object ID of the identity receiving the role."
  type        = string
}

variable "principal_type" {
  description = "Type of principal receiving the role assignment."
  type        = string
  default     = "ServicePrincipal"

  validation {
    condition = contains(
      [
        "ServicePrincipal",
        "User",
        "Group"
      ],
      var.principal_type
    )

    error_message = "principal_type must be ServicePrincipal, User, or Group."
  }
}