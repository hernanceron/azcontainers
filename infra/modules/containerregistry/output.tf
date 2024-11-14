output "acrname" {
  value = azurerm_container_registry.acrproyecto.login_server
}

output "serviceprincipalid" {
  value = data.azuread_service_principal.terraformHernan.id
}