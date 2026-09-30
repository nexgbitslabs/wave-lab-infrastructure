# ============================================================
# Azure Key Vault
# ============================================================

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                = lower("kv-${var.project_name}-${var.environment}")
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = var.sku_name

  # Use Azure RBAC instead of legacy access policies.
  rbac_authorization_enabled = true

  # Key Vault recovery protection.
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  # Kept configurable so the lab can later move toward
  # private endpoint-only access.
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags
}