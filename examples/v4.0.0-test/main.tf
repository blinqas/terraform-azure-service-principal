provider "azurerm" {
  features {}
}

module "service-principal" {
  source                         = "../../"
  app_name                       = "sp-tf-testing-v4"
  app_display_name               = "sp-tf-testing-v4"
  identifier_uri_verified_domain = "blinQVestLab.onmicrosoft.com"
  end_date_relative_hours        = "1440h"
  password_rotating_days         = 30
}


output "service_principal" {
  value       = module.service-principal.service_principal
  description = "The service principal generated by this module."
  sensitive   = true
}

output "application" {
  value       = module.service-principal.application
  description = "The Azure AD application generated by this module."
  sensitive   = true
}

output "service_principal_password" {
  value       = module.service-principal.service_principal_password
  sensitive   = true
  description = "The client_secret for the service principal"
}
