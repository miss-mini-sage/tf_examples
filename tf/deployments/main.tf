terraform {
  required_version = ">= 1.9.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.8.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0.2"
    }
  }
}

provider "azurerm" {
  subscription_id = "06466ead-6512-4dc4-8cbe-9a599f17701e"
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

provider "azuread" {
  tenant_id = "2ebc6bdf-9a09-41fd-88cd-5d3ac8221444"
}

data "azuread_group" "s_contributors" {
  display_name = "s_contributors"
  security_enabled = true
}

data "azuread_group" "kv_admins" {
  display_name = "kv_admins"
  security_enabled = true
}

data "azuread_group" "blob_owners" {
  display_name = "blob_owners"
  security_enabled = true
}

module "resource_group" {
  source            = "../modules/tf_resource_group"
  region            = "${var.region}"
  base_name         = "${var.base_name}"
  environmnet       = "${var.environmnet}"
}

module "storage_account" {
  source              = "../modules/tf_storage_account"
  region              = "${var.region}"
  base_name           = "${var.base_name}"
  environmnet         = "${var.environmnet}"

  depends_on          = [module.resource_group]
}

module "key_vault" {
  source            = "../modules/tf_key_vault"
  region            = "${var.region}"
  base_name         = "${var.base_name}"
  environmnet       = "${var.environmnet}"

  depends_on          = [module.resource_group]
}

resource "azurerm_key_vault_secret" "example" {
  name         = "secret-sauce"
  value        = "szechuan"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "storage_account_name" {
  name         = "storage-account-name"
  value        = module.storage_account.name
  key_vault_id = module.key_vault.id
}

resource "azuread_group_member" "miss_mini" {
  group_object_id  = data.azuread_group.s_contributors.object_id
  member_object_id = "f412a209-da23-46f7-a48f-6424704cf967"
}

resource "azurerm_role_assignment" "example" {
  scope                = module.key_vault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = "f412a209-da23-46f7-a48f-6424704cf967"
}