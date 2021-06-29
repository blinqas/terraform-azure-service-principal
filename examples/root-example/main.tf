provider "azurerm" {
    features {}
}

module "service-principal" {
    source = "../../"
    name   = "${var.name}-${terraform.workspace}"
}

variable "name" {
  type = string
  description = "The name of the service principal"
}