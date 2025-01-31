variable "region" {
  description = "Region to deploy resources"
  default = "westeurope"
}

variable "base_name" {
  description = "Base name for resources"
  default = "spacelift"
}

variable "environmnet" {
  description = "Environmnet resources are targetting"
  default = "local"
}
