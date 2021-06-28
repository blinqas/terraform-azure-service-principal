output "name" {
    value       = azuread_service_principal.sp.display_name
    description = "The name of the Azure AD application."
}

output "client_id" {
    value = azuread_application.app.application_id
    description = "The client_id/application_id of the service principal."
}

output "client_secret" {
    value = azuread_service_principal_password.pw.value
    sensitive = true
    description = "The client_secret for the service principal"
}

output "object_id" {
    value = azuread_service_principal.sp.id
    description = "The object_id of the service principal."
}

output "tenant_id" {
    value = data.azurerm_client_config.current.tenant_id
    description = ""
}