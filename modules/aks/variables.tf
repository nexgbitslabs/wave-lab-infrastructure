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
  description = "Resource Group containing the AKS cluster."
  type        = string
}

# ============================================================
# Networking
# ============================================================

variable "aks_subnet_id" {
  description = "Resource ID of the subnet used by AKS."
  type        = string
}

variable "service_cidr" {
  description = "CIDR used by Kubernetes services."
  type        = string
  default     = "172.20.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address assigned to Kubernetes DNS."
  type        = string
  default     = "172.20.0.10"
}

# ============================================================
# Monitoring
# ============================================================

variable "log_analytics_workspace_id" {
  description = "Azure resource ID of the Log Analytics workspace used by AKS."
  type        = string
}

# ============================================================
# System Node Pool
# ============================================================

variable "system_node_vm_size" {
  description = "VM size used by the AKS system node pool."
  type        = string
}

variable "system_node_count" {
  description = "Number of nodes in the AKS system node pool."
  type        = number

  validation {
    condition     = var.system_node_count >= 1
    error_message = "The system node pool must contain at least one node."
  }
}

# ============================================================
# User Node Pool
# ============================================================

variable "user_node_vm_size" {
  description = "VM size used by the AKS user node pool."
  type        = string
}

variable "user_node_count" {
  description = "Number of nodes in the AKS user node pool."
  type        = number

  validation {
    condition     = var.user_node_count >= 1
    error_message = "The user node pool must contain at least one node."
  }
}

# ============================================================
# Security
# ============================================================

variable "local_account_disabled" {
  description = "Whether local AKS administrator accounts are disabled."
  type        = bool
  default     = true
}

# ============================================================
# Tags
# ============================================================

variable "tags" {
  description = "Common tags applied to AKS resources."
  type        = map(string)
  default     = {}
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID used by AKS."
  type        = string
}