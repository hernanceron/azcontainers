output "primary_access_key" {
  value = azurerm_storage_account.proyecto_storage_account.primary_access_key
  sensitive = true
}

output "primary_connection_string" {
  value = azurerm_storage_account.proyecto_storage_account.primary_connection_string
  sensitive = true
}

output "storage_account_name" {
  value = azurerm_storage_account.proyecto_storage_account.name
}

output "primary_web_endpoint" {
  value = azurerm_storage_account.proyecto_storage_account.primary_web_endpoint
}
