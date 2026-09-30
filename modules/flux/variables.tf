# ============================================================
# AKS
# ============================================================

variable "cluster_id" {
  description = "Resource ID of the AKS cluster."
  type        = string
}

# ============================================================
# Flux Extension
# ============================================================

variable "extension_name" {
  description = "Name of the Flux extension installed on AKS."
  type        = string
  default     = "flux"
}

variable "configuration_name" {
  description = "Name of the Flux GitOps configuration."
  type        = string
  default     = "gitops"
}

variable "namespace" {
  description = "Namespace used by the Flux configuration."
  type        = string
  default     = "flux-system"
}

# ============================================================
# Git Repository
# ============================================================

variable "git_repository_url" {
  description = "Git repository reconciled by Flux."
  type        = string
}

variable "git_branch" {
  description = "Git branch reconciled by Flux."
  type        = string
  default     = "main"
}

variable "git_path" {
  description = "Path within the Git repository reconciled by Flux."
  type        = string
}