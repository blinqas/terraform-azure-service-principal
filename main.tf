terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "1.6.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.65.0"
    }
  }
}

# Get a data reference to the current subscription.
data "azurerm_subscription" "current" {}

# Get a data reference to the current provider config. Only used to output tenant_id.
data "azurerm_client_config" "current" {}

# Create the underlying application for the service principal.
resource "azuread_application" "app" {
  display_name = var.name
  identifier_uris = [
    format("http://%s", var.name)
  ]
}

# Create the service principal.
resource "azuread_service_principal" "sp" {
  application_id = azuread_application.app.application_id
}

# Set a random password for the service principal.
resource "azuread_service_principal_password" "pw" {
  service_principal_id = azuread_service_principal.sp.object_id
}

# Retrieve the data for the user specified role.
data "azurerm_role_definition" "main" {
  count = var.role == "" ? 0 : 1
  name  = var.role
}

# Assign user specified role(s) to the service principal.
resource "azurerm_role_assignment" "main" {
  count              = var.role == "" ? 0 : length(var.scopes)
  scope              = var.scopes[count.index]
  role_definition_id = format("%s%s", data.azurerm_subscription.current.id, data.azurerm_role_definition.main[0].id)
  principal_id       = azuread_service_principal.sp.id
}

# Temporary locals
locals {
  is_kv_enabled = var.key_vault_id != ""
  values_to_store = {
    client-id       = azuread_application.app.application_id
    client-secret   = azuread_service_principal_password.pw.value
    tenant-id       = data.azurerm_client_config.current.tenant_id
    subscription-id = data.azurerm_subscription.current.subscription_id
  }
}

# Store service principal credentials in the provided Key Vault
resource "azurerm_key_vault_secret" "secret" {
  count = local.is_kv_enabled ? length(local.values_to_store) : 0
  key_vault_id = var.key_vault_id
  name = format("%s%s", "kv-arm-", keys(local.values_to_store)[count.index])
  value = format("%s%s", "kv-arm-", lookup(local.values_to_store, keys(local.values_to_store)[count.index]))
}
