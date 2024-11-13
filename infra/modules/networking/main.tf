resource "azurerm_virtual_network" "vnetproyecto" {
  name = var.name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = [ "10.0.0.0/16" ]
  tags = {
    Entorno = "Desa"
  }
}
resource "azurerm_subnet" "subnetproyecto" {
  name = var.name_subnet
  address_prefixes = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.vnetproyecto.name
  resource_group_name = azurerm_virtual_network.vnetproyecto.resource_group_name
}