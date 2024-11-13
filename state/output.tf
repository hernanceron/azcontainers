output "resource_group_name" {
  value = azurerm_resource_group.terraform_state.name
}

output "storage_account_name" {
  value = azurerm_storage_account.terraform_state.name
}

output "primary_access_key" {
  value = azurerm_storage_account.terraform_state.primary_access_key
  sensitive = true
}