provider "azurerm" {
    features {}
}

module "service-principal" {
    source = "../../"
    name   = "sp-tf-${var.name}"
}

variable "name" {
  type = string
  description = "The name of the service principal"
}