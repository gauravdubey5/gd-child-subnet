# Unit test for gd-child-subnet

mock_provider "azurerm" {}

run "verify_subnet_plan" {
  command = plan

  variables {
    name                             = "snet-test-unit-001"
    resource_group_name              = "rg-test-subnet"
    virtual_network_name             = "vnet-test-subnet"
    address_prefixes                 = ["10.0.1.0/24"]
    associate_network_security_group = true
    network_security_group_id        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test-subnet/providers/Microsoft.Network/networkSecurityGroups/nsg-test"
  }

  assert {
    condition     = azurerm_subnet.subnet.name == "snet-test-unit-001"
    error_message = "Subnet name did not match expected value"
  }

  assert {
    condition     = length(azurerm_subnet_network_security_group_association.nsg_assoc) == 1
    error_message = "NSG association should be planned when associate_network_security_group is true"
  }
}
