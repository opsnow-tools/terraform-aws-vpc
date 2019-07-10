 variables
  
variable "cluster" {
  description = "Cluster name"
}

variable "name" {
  description = "Project name"
}

variable "auto_accept_peering" {
  description = "Whether to auto-accept the peering request"
  default = false
}

variable "tags" {
  type = "map"
  description = "Tags to apply"
  default = {}
}

variable "vpc_peering_id" {
  default = ""
}

variable "enable" {
  default = false
}
####################
## Requester Info ##
####################

variable "this_vpc_id" {
  description = "VPC ID of the requestor"
}

variable "this_cidr_block" {
  description = "CIDR block of the requestor"
}

variable "this_route_table_ids" {
  description = "Route table IDs of the requestor"
  type = "list"
  default = []
}

###################
## Accepter Info ##
###################

variable "peer_vpc_id" {
  description = "VPC ID of the peer"
}

variable "peer_region" {
  description = "Region of the peer"
}

variable "peer_profile" {
  description = "Profile of the peer"
}

variable "peer_cidr_block" {
  description = "CIDR block of the peer"
}

variable "peer_route_table_ids" {
  description = "Route table IDs of the peer"
  type = "list"
  default = []
}
