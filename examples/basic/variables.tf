variable "name" {
  type    = string
  default = "snet-example-basic"
}

variable "resource_group_name" {
  type    = string
  default = "rg-example-basic"
}

variable "virtual_network_name" {
  type    = string
  default = "vnet-example-basic"
}

variable "address_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "network_security_group_id" {
  type    = string
  default = null
}
