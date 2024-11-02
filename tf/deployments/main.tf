terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.95.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {
  tenant_id = "2ebc6bdf-9a09-41fd-88cd-5d3ac8221444"
}

module "storage_account" {
  source            = "../modules/tf_storage_account"
  region            = "${var.region}"
  base_name         = "${var.base_name}"
  environmnet       = "${var.environmnet}"
}

module "key_vault" {
  source            = "../modules/tf_key_vault"
  region            = "${var.region}"
  base_name         = "${var.base_name}"
  environmnet       = "${var.environmnet}"
}

resource "azuread_group_member" "miss_mini" {
  group_object_id  = "355f8522-d2bc-45ab-8f3f-fa0543d3418a"
  member_object_id = "f412a209-da23-46f7-a48f-6424704cf967"
}