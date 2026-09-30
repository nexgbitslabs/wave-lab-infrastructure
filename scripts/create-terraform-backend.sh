#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Wave Lab - Terraform Azure Backend Creation
# ============================================================
#
# Creates the Azure resources used for Terraform remote state.
#
# Resources:
#   - Resource Group
#   - Storage Account
#   - Blob Container
#
# This script is intentionally outside Terraform because
# Terraform cannot use an Azure backend before that backend
# exists.
# ============================================================

LOCATION="${LOCATION:-canadacentral}"
RESOURCE_GROUP="${RESOURCE_GROUP:-rg-wave-lab-tfstate-shared}"
CONTAINER_NAME="${CONTAINER_NAME:-tfstate}"

echo "========================================"
echo "Terraform Backend Creation"
echo "========================================"
echo "Location:       ${LOCATION}"
echo "Resource Group: ${RESOURCE_GROUP}"
echo "Container:      ${CONTAINER_NAME}"
echo ""

# ------------------------------------------------------------
# Verify Azure authentication
# ------------------------------------------------------------

echo "Checking Azure authentication..."

az account show >/dev/null 2>&1 || {
    echo "ERROR: Azure CLI is not authenticated."
    echo "Run: az login"
    exit 1
}

SUBSCRIPTION_ID=$(az account show --query id -o tsv)
SUBSCRIPTION_NAME=$(az account show --query name -o tsv)

echo "Subscription: ${SUBSCRIPTION_NAME}"
echo "Subscription ID: ${SUBSCRIPTION_ID}"
echo ""

# ------------------------------------------------------------
# Create Resource Group
# ------------------------------------------------------------

echo "Creating/verifying resource group..."

az group create \
    --name "${RESOURCE_GROUP}" \
    --location "${LOCATION}" \
    --tags \
        ManagedBy=AzureCLI \
        Project=wave-lab \
        Component=Terraform-State \
        Environment=shared \
    --output none

echo "Resource group ready."

# ------------------------------------------------------------
# Find or create Storage Account
# ------------------------------------------------------------

echo ""
echo "Checking for existing Terraform backend storage account..."

STORAGE_ACCOUNT=$(
    az storage account list \
        --resource-group "${RESOURCE_GROUP}" \
        --query "[0].name" \
        --output tsv
)

if [[ -z "${STORAGE_ACCOUNT}" ]]; then

    echo "No existing storage account found."
    echo "Generating storage account name..."

    SUFFIX=$(openssl rand -hex 3)
    STORAGE_ACCOUNT="stwavelabtf${SUFFIX}"

    echo "Storage Account: ${STORAGE_ACCOUNT}"
    echo ""
    echo "Creating storage account..."

    az storage account create \
        --name "${STORAGE_ACCOUNT}" \
        --resource-group "${RESOURCE_GROUP}" \
        --location "${LOCATION}" \
        --sku Standard_GRS \
        --kind StorageV2 \
        --min-tls-version TLS1_2 \
        --allow-blob-public-access false \
        --allow-shared-key-access true \
        --tags \
            ManagedBy=AzureCLI \
            Project=wave-lab \
            Component=Terraform-State \
            Environment=shared \
        --output none

    echo "Storage account created."

else

    echo "Existing storage account found:"
    echo "${STORAGE_ACCOUNT}"

fi

# ------------------------------------------------------------
# Create tfstate container
# ------------------------------------------------------------

echo ""
echo "Creating/verifying Terraform state container..."

az storage container create \
    --name "${CONTAINER_NAME}" \
    --account-name "${STORAGE_ACCOUNT}" \
    --auth-mode login \
    --output none

echo "Container ready."

# ------------------------------------------------------------
# Verification
# ------------------------------------------------------------

echo ""
echo "Verifying backend resources..."

az storage container show \
    --name "${CONTAINER_NAME}" \
    --account-name "${STORAGE_ACCOUNT}" \
    --auth-mode login \
    --output none

echo ""
echo "========================================"
echo "Terraform Backend Ready"
echo "========================================"
echo ""
echo "Resource Group:   ${RESOURCE_GROUP}"
echo "Storage Account:  ${STORAGE_ACCOUNT}"
echo "Container:        ${CONTAINER_NAME}"
echo ""
echo "Terraform state keys:"
echo "  bootstrap.terraform.tfstate"
echo "  dev.terraform.tfstate"
echo "  qa.terraform.tfstate"
echo "  uat.terraform.tfstate"
echo "  prod.terraform.tfstate"
echo ""
echo "Backend creation completed successfully."