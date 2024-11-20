output "nombre_db_expuesto" {
  value = azurerm_mysql_flexible_database.db_mysql.server_name
}

output "mysql_version" {
  value = azurerm_mysql_flexible_server.mysql_server.version
}