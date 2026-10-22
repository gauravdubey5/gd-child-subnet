variable "name" {
  description = "The name of the subnet. Must be between 1 and 80 characters."
  type        = string

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 80
    error_message = "Subnet name must be between 1 and 80 characters."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the subnet."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network to which to attach the subnet."
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)

  validation {
    condition     = length(var.address_prefixes) > 0
    error_message = "At least one address prefix must be specified."
  }
}

variable "associate_network_security_group" {
  description = "Whether to associate a Network Security Group with this subnet."
  type        = bool
  default     = false
}

variable "network_security_group_id" {
  description = "The Network Security Group ID to associate with this subnet when associate_network_security_group is true."
  type        = string
  default     = null
}

variable "associate_route_table" {
  description = "Whether to associate a Route Table with this subnet."
  type        = bool
  default     = false
}

variable "route_table_id" {
  description = "The Route Table ID to associate with this subnet when associate_route_table is true."
  type        = string
  default     = null
}

variable "service_endpoints" {
  description = "The list of service endpoints to associate with the subnet."
  type        = list(string)
  default     = []
}

variable "service_endpoint_policy_ids" {
  description = "The list of service endpoint policy IDs to associate with the subnet."
  type        = list(string)
  default     = []
}

variable "private_endpoint_network_policies" {
  description = "Enable or Disable network policies for the private endpoint on the subnet. Possible values: 'Disabled', 'Enabled', 'NetworkSecurityGroupEnabled', 'RouteTableEnabled'."
  type        = string
  default     = "Disabled"

  validation {
    condition     = contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.private_endpoint_network_policies)
    error_message = "Value must be one of: 'Disabled', 'Enabled', 'NetworkSecurityGroupEnabled', 'RouteTableEnabled'."
  }
}

variable "private_link_service_network_policies_enabled" {
  description = "Enable or Disable network policies for the private link service on the subnet."
  type        = bool
  default     = true
}

variable "delegations" {
  description = "Configuration delegations for services (e.g. Container Apps, App Service)."
  type = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string))
    })
  }))
  default = []
}
