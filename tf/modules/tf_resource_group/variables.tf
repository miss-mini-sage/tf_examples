variable "region" {
  description = "Region to deploy resources"
  default = "westeurope"
}

variable "base_name" {
  description = "Base name for resources"
}

variable "environmnet" {
  description = "Environmnet resources are targetting"
  default = "local"
}
