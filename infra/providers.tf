terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.8.0"
    }
    port = {
      source  = "port-labs/port-labs"
      version = "~> 1.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "my-infra-state-rg"
    storage_account_name = "myinfrastate"
    container_name = "tfstate"
    key = "dev/terraform.tfstate"
  }
}

provider "azurerm" {
    subscription_id = var.subscription_id
    features {
      
    }
}

provider "port" {
  client_id = var.port_client_id     # or set the env var PORT_CLIENT_ID
  secret    = var.port_client_secret # or set the env var PORT_CLIENT_SECRET
}