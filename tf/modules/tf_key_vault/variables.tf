variable "region" {
  description = "Region to deploy resources"
  default = "eu-west"
}

variable "base_name" {
  description = "Base name for resources"
}

variable "environmnet" {
  description = "Environmnet resources are targetting"
  default = "local"
}
