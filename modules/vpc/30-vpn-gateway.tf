# vpn-gateway

resource "aws_vpn_gateway" "this" {
  count = var.create_vpc && var.enable_vpn_gateway ? 1 : 0

  vpc_id          = data.aws_vpc.this.id
  amazon_side_asn = var.amazon_side_asn

  tags = merge(
    {
      "Name" = "${var.vpn_tags}-BESPIN-VPN"
    },
    var.tags,
  )
}

resource "aws_vpn_gateway_attachment" "this" {
  count = var.vpn_gateway_id != "" ? 1 : 0

  vpc_id         = data.aws_vpc.this.id
  vpn_gateway_id = var.vpn_gateway_id
}

resource "aws_customer_gateway" "main" {
  count      = "${var.customer_gateway && var.customer_gateway_id == "" ? 1 : 0}"
  bgp_asn    = "${var.bgp_asn}"
  ip_address = "${var.ip_address}"
  type       = "ipsec.1"

  tags = merge(
    {
    Name = "${var.vpn_tags}-BESPIN-GANGNAM"
    },
    var.tags,
  )
}
