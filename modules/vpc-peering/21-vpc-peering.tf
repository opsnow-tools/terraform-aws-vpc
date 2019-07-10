# vpc-peering
  
provider "aws" {
  alias = "peer"
  region = "${var.peer_region}"
  profile = "${var.peer_profile}"
}

########################
# Initiate the request #
########################
resource "aws_vpc_peering_connection" "this" {
  count         = "${var.enable ? 1 : 0}"
  vpc_id        = "${var.this_vpc_id}"
  peer_vpc_id   = "${var.peer_vpc_id}"
  peer_owner_id = "${data.aws_caller_identity.peer.account_id}"
  peer_region   = "${data.aws_region.peer.id}"
  auto_accept   = false
  tags = merge(
    {
      "Name" = "${local.full_name}"
    },
    var.tags,
  )
}

data "aws_vpc_peering_connection" "this" {
  id = var.vpc_peering_id == "" ? element(aws_vpc_peering_connection.this.*.id, 0) : var.vpc_peering_id
}

######################
# Accept the request #
######################
resource "aws_vpc_peering_connection_accepter" "peer" {
  count         = "${var.enable ? 1 : 0}"
  provider                  = "aws.peer"
  vpc_peering_connection_id = element(aws_vpc_peering_connection.this.*.id, count.index)
  auto_accept               = "${var.auto_accept_peering}"
  tags = merge(
    {
      "Name" = "${local.full_name}"
    },
    var.tags,
  )
}

########################
# Routes for requester #
########################
resource "aws_route" "route_tables" {
  count                     = "${var.enable ? length(var.this_route_table_ids) : 0}"
  route_table_id            = "${element(var.this_route_table_ids, count.index)}"
  destination_cidr_block    = "${var.peer_cidr_block}"
  vpc_peering_connection_id = element(aws_vpc_peering_connection.this.*.id, count.index)
  depends_on                = ["aws_vpc_peering_connection.this"]
}

########################
# Routes for accepter  #
########################
resource "aws_route" "peer_route_tables" {
  provider                  = "aws.peer"
  count                     = "${var.enable ? length(var.peer_route_table_ids) : 0}"
  route_table_id            = "${element(var.peer_route_table_ids, count.index)}"
  destination_cidr_block    = "${var.this_cidr_block}"
  vpc_peering_connection_id = element(aws_vpc_peering_connection.this.*.id, count.index)
  depends_on                = ["aws_vpc_peering_connection.this"]
}
