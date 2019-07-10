# variable
  
variable "city" {
  description = "City Name of the cluster, e.g: VIRGINIA"
  default = ""
}

variable "stage" {
  description = "Stage Name of the cluster, e.g: DEV"
  default = ""
}

variable "name" {
  description = "Name of the cluster, e.g: DEMO"
  default = ""
}

variable "vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

## Setting for VPC - VPN setting
variable "vpn_gateway_id" {
  description = "ID of VPN Gateway to attach to the VPC"
  default     = ""
}

## Setting for VPN connection
variable "customer_gateway_id" {
  description = "The id of the Customer Gateway."
  type        = string
  default     = ""
}

variable "create_vpn_connection" {
  description = "Set to false to prevent the creation of a VPN Connection."
  type        = bool
  default     = true
}

variable "vpc_subnet_route_table_ids" {
  description = "The ids of the VPC subnets for which routes from the VPN Gateway will be propagated."
  type        = list(string)
  default     = []
}

# Workaround for limitation when using computed values in count attribute
# https://github.com/hashicorp/terraform/issues/10857
variable "vpc_subnet_route_table_count" {
  description = "The number of subnet route table ids being passed in via `vpc_subnet_route_table_ids`."
  type        = number
  default     = 0
}

variable "vpn_connection_static_routes_only" {
  description = "Set to true for the created VPN connection to use static routes exclusively (only if `create_vpn_connection = true`). Static routes must be used for devices that don't support BGP."
  type        = bool
  default     = false
}

variable "vpn_connection_static_routes_destinations" {
  description = "List of CIDRs to be used as destination for static routes (used with `vpn_connection_static_routes_only = true`). Routes to destinations set here will be propagated to the routing tables of the subnets defined in `vpc_subnet_route_table_ids`."
  type        = list(string)
  default     = []
}

variable "tunnel1_inside_cidr" {
  description = "The CIDR block of the inside IP addresses for the first VPN tunnel."
  type        = string
  default     = ""
}

variable "tunnel2_inside_cidr" {
  description = "The CIDR block of the inside IP addresses for the second VPN tunnel."
  type        = string
  default     = ""
}

variable "tunnel1_preshared_key" {
  description = "The preshared key of the first VPN tunnel."
  type        = string
  default     = ""
}

variable "tunnel2_preshared_key" {
  description = "The preshared key of the second VPN tunnel."
  type        = string
  default     = ""
}

#Attachment can be already managed by the terraform-aws-vpc module by using the enable_vpn_gateway variable
variable "create_vpn_gateway_attachment" {
  description = "Set to false to prevent attachment of the vGW to the VPC"
  type        = bool
  default     = true
}
