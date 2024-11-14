output "acrname" {
  value = azurerm_container_registry.acrproyecto.login_server
}

output "acrnamelogin" {
  value = azurerm_container_registry.acrproyecto.name
}

output "serviceprincipalid" {
  value = data.azuread_service_principal.terraformHernan.id
}