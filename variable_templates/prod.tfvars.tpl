environment  = "qa"
location     = "canadacentral"
project_name = "wave-lab"

vnet_address_space = [
  "10.40.0.0/16"
]

aks_subnet_address_prefixes = [
  "10.40.10.0/24"
]

private_endpoint_subnet_address_prefixes = [
  "10.40.20.0/24"
]

aks_system_node_vm_size = "Standard_D2s_v5"
aks_system_node_count   = 2

aks_user_node_vm_size = "Standard_D4s_v5"
aks_user_node_count   = 2

acr_sku = "Premium"

key_vault_sku = "standard"

tags = {
  Environment    = "qa"
  ManagedBy      = "Terraform"
  Project        = "Wave-Migration-Lab"
  Classification = "Lab"
}