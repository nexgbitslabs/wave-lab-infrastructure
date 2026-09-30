# ============================================================
# Terraform Bootstrap Variable Template
# ============================================================

subscription_id = "${AZURE_SUBSCRIPTION_ID}"

location = "${AZURE_LOCATION}"

environment = "shared"

project_name = "${PROJECT_NAME}"

tags = {
  Environment    = "shared"
  ManagedBy      = "Terraform"
  Project        = "${PROJECT_NAME}"
  Classification = "Lab"
  Component      = "Terraform-State"
}