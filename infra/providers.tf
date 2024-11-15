terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.8.0"
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