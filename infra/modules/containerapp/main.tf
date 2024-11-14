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

resource "azurerm_container_app" "container_app" {
  name = var.name_container_app
  container_app_environment_id = azurerm_container_app_environment.azure_container_environment.id
  resource_group_name = var.resource_group_name
  revision_mode = "Single"
  template {
    container {
      name = "examplecontainerapp"
      image = "${var.acr_login_server}/go-transacciones:latest"
      cpu = 0.25
      memory = "0.5Gi"
    }
  }
}