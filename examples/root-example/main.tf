provider "azurerm" {
    features {}
}

module "service-principal" {
    source = "../../"
    name   = "sp-tf-${var.name}"
    key_vault_id = var.key_vault_id
}

variable "name" {
  type = string
  description = "The name of the service principal"
}

variable "key_vault_id" {
  type = string
  description = "The ID of the Key Vault to store credentials"
}