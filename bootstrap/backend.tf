// ============================================================
// Bootstrap Backend
// ============================================================
//
// The bootstrap configuration initially runs with Terraform's
// default local state.
//
// Jenkins creates the Azure Terraform state infrastructure first.
// After creation, Jenkins migrates this bootstrap state to the
// Azure Storage backend.
//
// Backend configuration is therefore supplied dynamically by
// Jenkins during the migration step.
// ============================================================

terraform {
  backend "azurerm" {}
}