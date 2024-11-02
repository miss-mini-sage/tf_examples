terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.95.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "azurerm_storage_account" {
  name                          = "st${var.base_name}${var.environmnet}"
  resource_group_name           = "rg-${var.base_name}-${var.environmnet}"
  location                      = "${var.region}"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  min_tls_version               = "TLS1_2"
  shared_access_key_enabled     = false
  public_network_access_enabled = false
  infrastructure_encryption_enabled = false

  tags = {
    environment = "${var.environmnet}"
  }
}