resource "azurerm_resource_group" "resource_group" {
  name          = "rg-${var.base_name}-${var.environmnet}"
  location      = "${var.region}"
}