# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "city" {
  description = "City Name of the cluster, e.g: VIRGINIA"
}

variable "stage" {
  description = "Stage Name of the cluster, e.g: DEV"
}

variable "name" {
  description = "Name of the cluster, e.g: DEMO"
}

variable "vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
  default     = "10.0.0.0/16"
}

variable "public_subnet_enable" {
  default = true
}

variable "public_subnet_count" {
  default = 0
}

variable "public_subnet_zones" {
  type    = list(string)
  default = []
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = []
}

variable "public_subnet_newbits" {
  default = 4
}

variable "public_subnet_netnum" {
  default = 0
}

variable "private_subnet_enable" {
  default = true
}

variable "private_subnet_count" {
  default = 0
}

variable "private_subnet_zones" {
  type    = list(string)
  default = []
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = []
}

variable "private_subnet_newbits" {
  default = 2
}

variable "private_subnet_netnum" {
  default = 1
}

variable "single_nat_gateway" {
  default = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

## Setting for VPC - VPN setting
variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
  type        = bool
  default     = false
}

variable "vpn_gateway_id" {
  description = "ID of VPN Gateway to attach to the VPC"
  default     = ""
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN."
  default     = "7224"
}

variable "vpn_tags" {
  description = "Additional tags for the VPN gateway"
  default     = ""
}

variable "customer_gateway" {
  description = "Default customer gateway"
  type        = bool
  default     = false
}

variable "customer_gateway_id" {
  description = "The id of the Customer Gateway."
  type        = string
  default     = ""
}

variable "bgp_asn" {
  default     = 65000
}

variable "ip_address" {
  description = "IP address for customer gateway ip"
  default     = ""
}

variable "vpc_peering_connection_id" {
  default = ""
}
