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

resource "azurerm_container_app" "container_app_proyecto" {
  name = var.name_container_app
  container_app_environment_id = azurerm_container_app_environment.azure_container_environment.id
  resource_group_name = var.resource_group_name
  revision_mode = "Single"
  template {
     container {
      name  = "my-container"
      image = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu = 0.25
      memory = "0.5Gi"         
    }
  }
  ingress {
    external_enabled = true
    target_port = 8080
    traffic_weight {
      percentage = 80
    }
  }
}