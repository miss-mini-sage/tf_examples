resource "azurerm_storage_account" "storage" {
  name                          = "st${var.base_name}${var.environmnet}"
  resource_group_name           = "rg-${var.base_name}-${var.environmnet}"
  location                      = "${var.region}"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  min_tls_version               = "TLS1_2"
  infrastructure_encryption_enabled = false

  tags = {
    environment = "${var.environmnet}"
  }
}