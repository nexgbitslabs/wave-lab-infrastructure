# =============================================================
# Azure
# =============================================================

subscription_id = "${AZURE_SUBSCRIPTION_ID}"
tenant_id       = "${AZURE_TENANT_ID}"

location     = "${AZURE_LOCATION}"
environment  = "dev"
project_name = "${PROJECT_NAME}"


# =============================================================
# Networking
# =============================================================

vnet_address_space = [
  "${VNET_ADDRESS_SPACE}"
]

aks_subnet_address_prefixes = [
  "${AKS_SUBNET_PREFIX}"
]

private_endpoint_subnet_address_prefixes = [
  "${PRIVATE_ENDPOINT_SUBNET_PREFIX}"
]


# =============================================================
# AKS
# =============================================================

aks_system_node_vm_size = "${AKS_SYSTEM_NODE_VM_SIZE}"
aks_system_node_count   = ${AKS_SYSTEM_NODE_COUNT}

aks_user_node_vm_size = "${AKS_USER_NODE_VM_SIZE}"
aks_user_node_count   = ${AKS_USER_NODE_COUNT}


# =============================================================
# Azure Container Registry
# =============================================================

acr_sku = "${ACR_SKU}"


# =============================================================
# Key Vault
# =============================================================

key_vault_sku = "${KEY_VAULT_SKU}"


# =============================================================
# Tags
# =============================================================

tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
  Project     = "${PROJECT_NAME}"
}