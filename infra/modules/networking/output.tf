output "vnet_id" {
  value = azurerm_virtual_network.vnetproyecto.id
}
output "vnet_name" {
  value = azurerm_virtual_network.vnetproyecto.name
}

output "subnet_id" {
  value = azurerm_subnet.subnetproyecto.id
}

output "subnet_name" {
  value = azurerm_subnet.subnetproyecto.name
}