output "acrname" {
  value = module.azure_container_registry.acrname
}
output "acrnamelogin" {
  value = module.azure_container_registry.acrnamelogin
}
output "resource_group_name" {
  value = azurerm_resource_group.rg-proyecto.name
}