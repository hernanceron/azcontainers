resource "random_pet" "prefix" {  
}
resource "azurerm_resource_group" "rg-proyecto" {
  name = "${random_pet.prefix.id}-rg"
  location = "eastus"
}
module "networking_proyecto" {
  source = "./modules/networking"
  resource_group_name = azurerm_resource_group.rg-proyecto.name
  name = "${random_pet.prefix.id}-vnet"
  name_subnet = "${random_pet.prefix.id}-subnet"
  location = "eastus"
}
module "storage_container_proyecto" {
    source = "./modules/storageaccount"
    resource_group_name = azurerm_resource_group.rg-proyecto.name
    name = "storageaccountschca"
    name_storage_container = "blobstoragecontainer"
    location = "eastus"
}

module "azure_function_proyecto" {
  source = "./modules/azurefunction"
  resource_group_name = azurerm_resource_group.rg-proyecto.name
  function_name = "azfunctionproyectohca"
  location = "eastus2"
  name = "azname2"
  storage_account_name = module.storage_container_proyecto.storage_account_name
  primary_connection_string = module.storage_container_proyecto.primary_connection_string
  storage_account_access_key = module.storage_container_proyecto.primary_access_key
}

module "azure_container_registry" {
  source = "./modules/containerregistry"
  location = "eastus2"
  name_acr = "acrregistryhca"
  resource_group_name = azurerm_resource_group.rg-proyecto.name
}

module "azure_container_app" {
  source = "./modules/containerapp"
  acr_login_server = module.azure_container_registry.acrname
  resource_group_name = azurerm_resource_group.rg-proyecto.name  
  location = "eastus2"
  name_container_app = "azcontainerapphca"
  name_container_environment = "azcontainerenvironmenthca"
  name_log_analytics = "azloghca"
}