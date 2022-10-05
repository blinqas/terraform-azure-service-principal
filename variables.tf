variable "app_display_name" {
  type        = string
  description = "The name of the service principal"
}

variable "app_name" {
  type        = string
  description = "The name of the application (normally the project name)"
}

variable "identifier_uri_verified_domain" {
  type        = string
  description = "Change since October 2021 requires a verified domain of the organization or its subdomain."
}

variable "password_rotating_days" {
  type        = number
  description = "Number in days the password for the service principal should rotate. When this number is reached, the password resource is destroyed and recreated. It requires Terraform to be run at all for any change to occur."
  default     = 7
}

variable "end_date_relative_hours" {
  type        = string
  description = "Relative day from today that the service principal password expires."
  default     = "168h"
}

