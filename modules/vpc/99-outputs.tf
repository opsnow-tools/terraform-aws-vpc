# output

output "vpc_id" {
  value = data.aws_vpc.this.id
}

output "vpc_cidr" {
  value = data.aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

output "public_subnet_cidr" {
  value = aws_subnet.public.*.cidr_block
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "private_subnet_cidr" {
  value = aws_subnet.private.*.cidr_block
}

output "nat_ip" {
  value = aws_eip.private.*.public_ip
}

# Output more add
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = concat(aws_internet_gateway.this.*.id, [""])[0]
}

output "public_route_table_ids" {
  value       = aws_route_table.public.*.id
}

output "private_route_table_ids" {
  value       = aws_route_table.private.*.id
}

output "eip_private_ids" {
  value       = aws_eip.private.*.id
}

output "public_route_table_association_ids" {
  value       = aws_route_table_association.public.*.id
}

output "private_route_table_association_ids" {
  value       = aws_route_table_association.private.*.id
}

output "nat_gateway_private_ids"{
  value       = aws_nat_gateway.private.*.id
}

## Setting for VPC - VPN
output "vgw_id" {
  description = "The ID of the VPN Gateway"
  value = concat(
    aws_vpn_gateway.this.*.id,
    aws_vpn_gateway_attachment.this.*.vpn_gateway_id,
    [""],
  )[0]
}

output "customer_gateway_main_id" {
  description = "Output for customer_gateway_id"
  value = concat(aws_customer_gateway.main.*.id,[""])[0]
}
