# ============================================================
# Microsoft Flux Extension
# ============================================================

resource "azurerm_kubernetes_cluster_extension" "flux" {
  name           = var.extension_name
  cluster_id     = var.cluster_id
  extension_type = "microsoft.flux"
}

# ============================================================
# Flux GitOps Configuration
# ============================================================

resource "azurerm_kubernetes_flux_configuration" "this" {
  name       = var.configuration_name
  cluster_id = var.cluster_id
  namespace  = var.namespace

  scope = "cluster"

  continuous_reconciliation_enabled = true

  git_repository {
    url = var.git_repository_url

    reference_type  = "branch"
    reference_value = var.git_branch

    sync_interval_in_seconds = 60
  }

  kustomizations {
    name = "cluster"

    path = var.git_path

    sync_interval_in_seconds  = 60
    retry_interval_in_seconds = 60

    garbage_collection_enabled = true
    wait                       = true
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux
  ]
}