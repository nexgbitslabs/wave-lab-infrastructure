## USEFUL COMMANDS

1. CREATE SPN

<script>
// First explicitly select the intended subscription
az account set --subscription "nexgbits"

//Verify:
az account show \
  --query "{Name:name, SubscriptionId:id, TenantId:tenantId, State:state}" \
  --output table

//Then create a dedicated service principal for the Terraform lab:
az ad sp create-for-rbac \
  --name "sp-wave-lab-terraform" \
  --role "Contributor" \
  --scopes "/subscriptions/a3fcb44b-8229-4e41-99c5-fbebb9ffb8bf"

//output
"appId": "xxxxx",
  "displayName": "sp-wave-lab-terraform",
  "password": "xxxx",
  "tenant": "xxxxx"

//NB assign contributor at subscription scope to the sp-wave-lab-terraform
Contributor
</script>

