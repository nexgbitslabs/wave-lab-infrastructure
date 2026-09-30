# ============================================================
# Terraform Bootstrap Backend
# ============================================================
#
# The bootstrap configuration creates the Azure resources
# required for remote Terraform state.
#
# Therefore bootstrap itself initially uses local state.
# ============================================================

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}