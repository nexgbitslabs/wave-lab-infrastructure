# ============================================================
# Azure Kubernetes Service
# ============================================================

resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${var.project_name}-${var.environment}"

  # ==========================================================
  # System Node Pool
  # ==========================================================

  default_node_pool {
    name           = "system"
    vm_size        = var.system_node_vm_size
    node_count     = var.system_node_count
    vnet_subnet_id = var.aks_subnet_id

    type = "VirtualMachineScaleSets"

    only_critical_addons_enabled = true

    upgrade_settings {
      max_surge = "10%"
    }
  }

  # ==========================================================
  # Managed Identity
  # ==========================================================

  identity {
    type = "SystemAssigned"
  }

  # ==========================================================
  # Networking
  # ==========================================================

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"

    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  # ==========================================================
  # Microsoft Entra ID / Azure RBAC
  # ==========================================================

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
  }

  role_based_access_control_enabled = true

  # ==========================================================
  # Workload Identity
  # ==========================================================

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  # ==========================================================
  # Monitoring
  # ==========================================================

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  # ==========================================================
  # Security
  # ==========================================================

  local_account_disabled = var.local_account_disabled

  tags = var.tags
}

# ============================================================
# AKS User Node Pool
# ============================================================

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id

  vm_size    = var.user_node_vm_size
  node_count = var.user_node_count

  vnet_subnet_id = var.aks_subnet_id

  mode = "User"

  upgrade_settings {
    max_surge = "10%"
  }

  tags = var.tags
}