# Set a random password for the service principal.
resource "azuread_service_principal_password" "pw" {
  service_principal_id = azuread_service_principal.sp.object_id
  end_date_relative    = var.end_date_relative_hours
  rotate_when_changed = {
    rotation = time_rotating.sp.id
  }
}

# Rotate this resource at time of variable value
resource "time_rotating" "sp" {
  rotation_days = var.password_rotating_days
}

