resource "azurerm_resource_group" "rg-proyecto" {
  name = "${var.nombre_proyecto}-rg"
  location = var.location
}
module "networking_proyecto" {
  source = "./modules/networking"
  resource_group_name = azurerm_resource_group.rg-proyecto.name
  name = "${var.nombre_proyecto}-vnet"
  name_subnet = "${var.nombre_proyecto}-subnet"
  location = var.location
}
module "storage_container_proyecto" {
    source = "./modules/storageaccount"
    resource_group_name = azurerm_resource_group.rg-proyecto.name
    name = "storageaccountschca"
    name_storage_container = "blobstoragecontainer"
    location = var.location
}

module "azure_function_proyecto" {
  source = "./modules/azurefunction"
  resource_group_name = azurerm_resource_group.rg-proyecto.name
  function_name = "azfunctionproyectohca"
  location = var.location
  name = "azname2"
  storage_account_name = module.storage_container_proyecto.storage_account_name
  primary_connection_string = module.storage_container_proyecto.primary_connection_string
  storage_account_access_key = module.storage_container_proyecto.primary_access_key
}

module "azure_container_registry" {
  source = "./modules/containerregistry"
  location = var.location
  name_acr = "acrregistryhca"
  resource_group_name = azurerm_resource_group.rg-proyecto.name
}

module "azure_container_app" {
  source = "./modules/containerapp"
  acr_login_server = module.azure_container_registry.acrname
  resource_group_name = azurerm_resource_group.rg-proyecto.name  
  location = var.location
  name_container_app = "azcontainerapphca"
  name_container_environment = "azcontainerenvironmenthca"
  name_log_analytics = "azloghca"
}

resource "port_entity" "azure_storage_account" {
  count      = length(module.storage_container_proyecto) > 0 ? 1 : 0
  identifier = module.storage_container_proyecto.storage_account_name
  title      = module.storage_container_proyecto.storage_account_name
  blueprint  = "azureStorage"
  run_id     = var.port_run_id
  properties = {
    string_props = {
      "storage_name"     = module.storage_container_proyecto.storage_account_name,
      "storage_location" = var.location,
      "endpoint"         = module.storage_container_proyecto.primary_web_endpoint
    }
  }

  depends_on = [module.storage_container_proyecto]
}

resource "port_entity" "azure_function" {  
  identifier = module.azure_function_proyecto.azure_function_name
  title      = module.azure_function_proyecto.azure_function_name
  blueprint  = "azureFunction"
  run_id     = var.port_run_id
  properties = {
    string_props = {
      "function_name"     = module.azure_function_proyecto.azure_function_name,
      "azfunction_location" = var.location
    }
  }

  depends_on = [module.azure_function_proyecto]
}

resource "port_entity" "azure_container_registry" {  
  identifier = module.azure_container_registry.acrnamelogin
  title      = module.azure_container_registry.acrnamelogin
  blueprint  = "azure_container_registry"
  run_id     = var.port_run_id
  properties = {
    string_props = {
      "location"     = var.location
      "server_name" = module.azure_container_registry.acrname
    }
  }

  depends_on = [module.azure_container_registry]
}


resource "port_entity" "azure_container_environment" {  
  identifier = module.azure_container_app.environment_name
  title      = module.azure_container_app.environment_name
  blueprint  = "azureContainerEnvironment"
  run_id     = var.port_run_id
  properties = {
    string_props = {
      "storage_location"     = var.location
      "storage_name" = module.azure_container_app.environment_name
    }
  }

  depends_on = [module.azure_container_app]
}