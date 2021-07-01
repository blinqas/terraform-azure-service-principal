variable "name" {
  type = string
  description = "The name of the service principal"
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
  description = "The ID of the Key Vault to store service principal credentials. Defaults to \"\""
  default = ""
}