terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.21.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.3.0"
    }
  }
}

# Get a data reference to the current subscription.
data "azurerm_subscription" "current" {}

# Get a data reference to the current provider config. Only used to output tenant_id.
data "azurerm_client_config" "current" {}

# Create the underlying application for the service principal.
resource "azuread_application" "app" {
  display_name = var.app_display_name
  identifier_uris = [
    format("http://%s.%s", var.app_name, var.identifier_uri_verified_domain)
  ]
}

# Create the service principal.
resource "azuread_service_principal" "sp" {
  application_id = azuread_application.app.application_id
}

# Rotate this resource at time of variable value
resource "time_rotating" "sp" {
  rotation_days = var.password_rotating_days
}

# Set a random password for the service principal.
resource "azuread_service_principal_password" "pw" {
  service_principal_id = azuread_service_principal.sp.object_id
  end_date_relative    = var.end_date_relative_hours
  rotate_when_changed = {
    rotation = time_rotating.sp.id
  }
}

