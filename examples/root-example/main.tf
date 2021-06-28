provider "azurerm" {
    features {}
}

module "service-principal" {
    source = "../../"
    name   = "sp-blinq-${terraform.workspace}"
}