# output
  
output "aws_vpc_peering_connection" {
  value = aws_vpc_peering_connection.this
}

output "vpc_peering_id" {
  value = aws_vpc_peering_connection.this.*.id
}
