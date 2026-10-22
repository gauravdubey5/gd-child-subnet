terraform {
  required_version = ">= 1.5.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.75.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "subnet" {
  source = "../../"

  name                      = var.name
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.virtual_network_name
  address_prefixes          = var.address_prefixes
  network_security_group_id = var.network_security_group_id
}
