terraform {
  backend "azurerm" {
    resource_group_name  = "rg-wave-lab-tfstate-shared"
    storage_account_name = "stwavelabtff8ce57"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
    use_azuread_auth     = true
  }
}