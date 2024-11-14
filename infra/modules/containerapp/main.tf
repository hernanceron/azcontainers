resource "azurerm_log_analytics_workspace" "log_workspace" {
  name = var.name_log_analytics
  location = var.location
  resource_group_name = var.resource_group_name
  sku = "PerGB2018"
  retention_in_days = 30
}

resource "azurerm_container_app_environment" "azure_container_environment" {
  name = var.name_container_environment
  location = var.location
  resource_group_name = var.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_workspace.id
}
