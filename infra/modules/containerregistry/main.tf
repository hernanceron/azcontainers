data "azuread_service_principal" "terraformHernan" {
  display_name = "terraformHernan"
}

resource "azurerm_container_registry" "acrproyecto" {
  name = var.name_acr
  resource_group_name = var.resource_group_name
  location = var.location
  sku = "Basic"
  admin_enabled = true
}

resource "azurerm_role_assignment" "roleproyecto" {
  principal_id = data.azuread_service_principal.terraformHernan.object_id
  role_definition_name = "AcrPull"
  scope = azurerm_container_registry.acrproyecto.id
  depends_on = [ azurerm_container_registry.acrproyecto ]
}