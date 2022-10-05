# Create the underlying application for the service principal.
resource "azuread_application" "app" {
  display_name = var.app_display_name
  identifier_uris = [
    format("http://%s.%s", var.app_name, var.identifier_uri_verified_domain)
  ]
}
