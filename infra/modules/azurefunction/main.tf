resource "azurerm_service_plan" "planaz_proyecto" {
  name = var.name
  resource_group_name = var.resource_group_name
  location = var.location
  os_type = "Linux"
  sku_name = "F1"
}

resource "azurerm_linux_function_app" "linux_function_proyecto" {
  name = var.function_name
  resource_group_name = var.resource_group_name
  location = var.location

  storage_account_name = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  service_plan_id = azurerm_service_plan.planaz_proyecto.id

  site_config {
    
  }

  app_settings = {
    "AzureWebJobsStorage" = var.primary_connection_string
    "FUNCTIONS_EXTENSION_VERSION" = "~3"
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}