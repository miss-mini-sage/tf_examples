terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name          = "rg-${var.base_name}-${var.environmnet}"
  location      = "${var.region}"
}