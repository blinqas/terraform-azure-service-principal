# Get a data reference to the current subscription.
data "azurerm_subscription" "current" {}

# Get a data reference to the current provider config. Only used to output tenant_id.
data "azurerm_client_config" "current" {}

