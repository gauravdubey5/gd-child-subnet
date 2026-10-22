resource "azurerm_subnet" "subnet" {
  name                                          = var.name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.virtual_network_name
  address_prefixes                              = var.address_prefixes
  service_endpoints                             = length(var.service_endpoints) > 0 ? var.service_endpoints : null
  service_endpoint_policy_ids                   = length(var.service_endpoint_policy_ids) > 0 ? var.service_endpoint_policy_ids : null
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled

  dynamic "delegation" {
    for_each = var.delegations
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  count                     = var.associate_network_security_group ? 1 : 0
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = var.network_security_group_id
}

resource "azurerm_subnet_route_table_association" "rt_assoc" {
  count          = var.associate_route_table ? 1 : 0
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = var.route_table_id
}
