resource "azurerm_storage_account" "proyecto_storage_account" {
  name = var.name
  resource_group_name = var.resource_group_name
  location = var.location
  account_tier    = "Standard"
  account_kind = "StorageV2"
  account_replication_type = "LRS"
  
  tags = {
    Entorno = "Desa"
  }
}

resource "azurerm_storage_container" "proyecto_storage_container" {
  name = var.name_storage_container
  storage_account_name = azurerm_storage_account.proyecto_storage_account.name
  container_access_type = "private"
}