resource "random_string" "storage_suffix" {
  length  = 6
  upper   = false
  special = false
}

locals {
  resource_group_name = "rg-${var.project_name}-tfstate-${var.environment}"

  # Storage account names cannot contain hyphens.
  storage_account_name = substr(
    lower(
      replace(
        "st${var.project_name}tf${random_string.storage_suffix.result}",
        "-",
        ""
      )
    ),
    0,
    24
  )

  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )
}

resource "azurerm_resource_group" "terraform_state" {
  name     = local.resource_group_name
  location = var.location

  tags = local.common_tags
}

resource "azurerm_storage_account" "terraform_state" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.terraform_state.name
  location                 = azurerm_resource_group.terraform_state.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  min_tls_version = "TLS1_2"

  shared_access_key_enabled       = false
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 30
    }

    container_delete_retention_policy {
      days = 30
    }
  }

  tags = local.common_tags
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.terraform_state.id
  container_access_type = "private"
}