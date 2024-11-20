resource "azurerm_mysql_flexible_server" "mysql_server" {
  name = var.name_database_server
  resource_group_name = var.resource_group_name
  location = var.location
  administrator_login = var.admin_username
  administrator_password = var.administrator_password
  version = "8.0.21"
  sku_name = "B_Standard_B1s"
}

resource "azurerm_mysql_flexible_database" "db_mysql" {
  name = var.name_database
  server_name = azurerm_mysql_flexible_server.mysql_server.name
  resource_group_name = azurerm_mysql_flexible_server.mysql_server.resource_group_name
  charset = "utf8"
  collation = "utf8_unicode_ci"
}