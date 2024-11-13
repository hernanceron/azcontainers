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