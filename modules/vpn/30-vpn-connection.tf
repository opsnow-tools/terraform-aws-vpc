# vpn connection
  
resource "aws_vpn_connection" "default" {
  count = var.create_vpn_connection && local.tunnel_details_not_specified ? 1 : 0

  vpn_gateway_id      = var.vpn_gateway_id
  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tags = merge(
    {
      "Name" = "${local.full_name}-BESPIN-GANGNAM"
    },
    var.tags,
  )
}

### Tunnel Inside CIDR only
resource "aws_vpn_connection" "tunnel" {
  count = var.create_vpn_connection && local.create_tunner_with_internal_cidr_only ? 1 : 0

  vpn_gateway_id      = var.vpn_gateway_id
  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tunnel1_inside_cidr = var.tunnel1_inside_cidr
  tunnel2_inside_cidr = var.tunnel2_inside_cidr

  tags = merge(
    {
      "Name" = "${local.full_name}-BESPIN-GANGNAM"
    },
    var.tags,
  )
}

### Preshared Key only
resource "aws_vpn_connection" "preshared" {
  count = var.create_vpn_connection && local.create_tunner_with_preshared_key_only ? 1 : 0

  vpn_gateway_id      = var.vpn_gateway_id
  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  tags = merge(
    {
      "Name" = "${local.full_name}-BEPSIN-GANGNAM"
    },
    var.tags,
  )
}

### Tunnel Inside CIDR and Preshared Key
resource "aws_vpn_connection" "tunnel_preshared" {
  count = var.create_vpn_connection && local.tunnel_details_specified ? 1 : 0

  vpn_gateway_id      = var.vpn_gateway_id
  customer_gateway_id = var.customer_gateway_id
  type                = "ipsec.1"

  static_routes_only = var.vpn_connection_static_routes_only

  tunnel1_inside_cidr = var.tunnel1_inside_cidr
  tunnel2_inside_cidr = var.tunnel2_inside_cidr

  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  tags = merge(
    {
      "Name" = "${local.full_name}-BESPIN-GANGNAM"
    },
    var.tags,
  )
}

resource "aws_vpn_connection_route" "default" {
  count = var.create_vpn_connection && var.vpn_connection_static_routes_only ? length(var.vpn_connection_static_routes_destinations) : 0

  vpn_connection_id = local.create_tunner_with_internal_cidr_only ? aws_vpn_connection.tunnel[0].id : local.create_tunner_with_preshared_key_only ? aws_vpn_connection.preshared[0].id : local.tunnel_details_specified ? aws_vpn_connection.tunnel_preshared[0].id : aws_vpn_connection.default[0].id

  destination_cidr_block = element(var.vpn_connection_static_routes_destinations, count.index)
}

#resource "aws_vpn_gateway_route_propagation" "public" {
#  count = var.create_vpc && var.propagate_public_route_tables_vgw && (var.enable_vpn_gateway || var.vpn_gateway_id != "") ? 1 : 0
#
#  route_table_id = element(aws_route_table.public.*.id, count.index)
#  vpn_gateway_id = element(
#    concat(
#      aws_vpn_gateway.this.*.id,
#      aws_vpn_gateway_attachment.this.*.vpn_gateway_id,
#    ),
#    count.index,
#  )
#}

#resource "aws_vpn_gateway_route_propagation" "private" {
#  count = var.create_vpc && var.propagate_private_route_tables_vgw && (var.enable_vpn_gateway || var.vpn_gateway_id != "") ? length(var.private_subnets) : 0
#
#  route_table_id = element(aws_route_table.private.*.id, count.index)
#  vpn_gateway_id = element(
#    concat(
#      aws_vpn_gateway.this.*.id,
#      aws_vpn_gateway_attachment.this.*.vpn_gateway_id,
#    ),
#    count.index,
#  )
#}
