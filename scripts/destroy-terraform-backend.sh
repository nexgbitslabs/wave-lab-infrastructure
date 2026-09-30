#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Wave Lab - Terraform Azure Backend Destruction
# ============================================================
#
# WARNING:
# This deletes the resource group containing Terraform state.
#
# All environment state stored in the backend will be lost.
# ============================================================

RESOURCE_GROUP="${RESOURCE_GROUP:-rg-wave-lab-tfstate-shared}"

echo "========================================"
echo "Terraform Backend Destruction"
echo "========================================"
echo ""
echo "WARNING:"
echo "This will permanently delete:"
echo ""
echo "  ${RESOURCE_GROUP}"
echo ""
echo "including all Terraform state files."
echo ""

az account show >/dev/null 2>&1 || {
    echo "ERROR: Azure CLI is not authenticated."
    echo "Run: az login"
    exit 1
}

if ! az group exists \
    --name "${RESOURCE_GROUP}" \
    --output tsv | grep -q true; then

    echo "Resource group does not exist."
    echo "Nothing to destroy."
    exit 0
fi

echo "Resources currently in backend resource group:"
echo ""

az resource list \
    --resource-group "${RESOURCE_GROUP}" \
    --query "[].{Name:name,Type:type}" \
    --output table

echo ""
read -r -p "Type DELETE to permanently remove the Terraform backend: " CONFIRMATION

if [[ "${CONFIRMATION}" != "DELETE" ]]; then
    echo ""
    echo "Destruction cancelled."
    exit 0
fi

echo ""
echo "Deleting Terraform backend resource group..."

az group delete \
    --name "${RESOURCE_GROUP}" \
    --yes

echo ""
echo "Waiting for deletion to complete..."

while az group exists \
    --name "${RESOURCE_GROUP}" \
    --output tsv | grep -q true
do
    echo "Backend resource group is still deleting..."
    sleep 10
done

echo ""
echo "========================================"
echo "Terraform Backend Destroyed"
echo "========================================"
echo ""
echo "${RESOURCE_GROUP} no longer exists."