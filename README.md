# gd-child-subnet: Azure Subnet Terraform Module

This child module creates and manages an Azure Subnet within a Virtual Network, with automated Network Security Group (NSG) and Route Table associations, service endpoints, and delegations.

Part of the **Azure Parent–Child Infrastructure Architecture** under GitHub account `gauravdubey5`.

## Features

- Subnet provisioning with CIDR prefix validation
- Automated association with Network Security Groups (`gd-child-nsg`)
- Automated association with Route Tables (`gd-child-route-table`)
- Service Endpoints and Private Endpoint policy configuration
- Subnet delegations (e.g. for Container Apps, App Service, Azure SQL)
- Compatible with Terraform `>= 1.5.0` and AzureRM provider `>= 3.75.0, < 5.0.0`

## Prerequisites

- Existing Resource Group (`gd-child-rg`)
- Existing Virtual Network (`gd-child-vnet`)
- Existing NSG (`gd-child-nsg`) when NSG association is enabled

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Name of the Subnet | `string` | n/a | yes |
| `resource_group_name` | Name of the parent Resource Group | `string` | n/a | yes |
| `virtual_network_name` | Name of the parent Virtual Network | `string` | n/a | yes |
| `address_prefixes` | List of CIDR address prefixes | `list(string)` | n/a | yes |
| `network_security_group_id` | ID of the NSG to associate | `string` | `null` | no |
| `route_table_id` | ID of the Route Table to associate | `string` | `null` | no |
| `service_endpoints` | List of service endpoints to enable | `list(string)` | `[]` | no |
| `service_endpoint_policy_ids` | List of service endpoint policy IDs | `list(string)` | `[]` | no |
| `private_endpoint_network_policies` | Private endpoint network policies | `string` | `"Disabled"` | no |
| `private_link_service_network_policies_enabled` | Private link network policies | `bool` | `true` | no |
| `delegations` | Subnet delegation configurations | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The Resource ID of the Subnet |
| `name` | The Name of the Subnet |
| `resource_group_name` | The Resource Group name |
| `virtual_network_name` | The Virtual Network name |
| `address_prefixes` | The CIDR prefixes of the Subnet |

## Example Usage

```hcl
module "subnet" {
  source = "git::https://github.com/gauravdubey5/gd-child-subnet.git?ref=v1.0.0"

  name                      = "snet-workload-dev-001"
  resource_group_name       = module.rg.name
  virtual_network_name      = module.vnet.name
  address_prefixes          = ["10.10.1.0/24"]
  network_security_group_id = module.nsg.id
}
```

## Security Considerations

- Always associate an NSG (`network_security_group_id`) to enforce strict inbound and outbound traffic filtering.
- Keep `private_endpoint_network_policies` disabled unless specific UDR/NSG inspection is configured for private endpoints.

## Cost Considerations

- Subnets and subnet associations carry **$0.00 / month** in Azure.

## Testing & Verification

```bash
terraform fmt -check
terraform init -backend=false
terraform validate
terraform test
```
