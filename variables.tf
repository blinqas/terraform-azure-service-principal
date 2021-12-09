variable "name" {
  type = string
  description = "The name of the service principal"
}

variable "app_name" {
  type = string
  description = "The name of the application (normally the project name)"
}

variable "role" {
  type = string
  description = "The name of a role for the service principal. Does nothing if var.scopes isn't set."
  default = ""
}

variable "scopes" {
  type = list(string)
  description = "A list of scopes the role assignment applies to. Defaults to []"
  default = []
}

variable "key_vault_id" {
  type = string
  description = "The ID of the Key Vault to store service principal credentials. Do not use a key vault that generates an access policy assigned to the this service principal. Causes a dependency loop. Defaults to \"\""
  default = ""
}

variable "identifier_uri_verified_domain" {
  type = string
  description = "Change since October 2021 requires a verified domain of the organization or its subdomain. Example: wwan.no"
}