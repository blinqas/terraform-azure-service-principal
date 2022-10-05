# Create the service principal.
resource "azuread_service_principal" "sp" {
  application_id = azuread_application.app.application_id
}

