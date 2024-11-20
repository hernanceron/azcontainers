variable "name_database_server" {
  type = string
  description = "Nombre del servidor de base de datos"
}

variable "name_database" {
  type = string
  description = "Nombre de la base de datos"
}

variable "resource_group_name" {
  type = string
  description = "Nombre del resource group"
}

variable "location" {
  type = string
  description = "Locacion del recurso"
}

variable "admin_username" {
  type = string
  description = "Usuario administrador"
}

variable "administrator_password" {
  type = string
  description = "Password administrador"
}