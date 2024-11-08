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

  #backend "azurerm" {
  #  resource_group_name  = "tf_backend"                     # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
  #  storage_account_name = "tfaggdbackend"                     # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
  #  container_name       = "tfstate"                        # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
  #  key                  = "terraform.tfstate"              # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  #  use_azuread_auth     = true                             # Can also be set via `ARM_USE_AZUREAD` environment variable.
  #}
}

provider "azurerm" {
  subscription_id = "ADD VALUE"
  # client_id = "ADD VALUE"
  # client_secret = "ADD VALUE"
  storage_use_azuread = true
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = false
    }
  }
}

provider "azuread" {
  tenant_id = "ADD VALUE"
}

data "azuread_group" "s_contributors" {
  display_name = "s_contributors"
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
  member_object_id = "ADD VALUE"
}

resource "azurerm_role_assignment" "example" {
  scope                = module.key_vault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = "ADD VALUE"
}

resource "null_resource" "this" {
 count = 2 > 1 ? 1 : 0
}