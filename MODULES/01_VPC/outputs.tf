output "vpc_id" {
  value       = aws_vpc.this_vpc.id
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = aws_subnet.this_public_subnet.*.id
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = aws_subnet.this_private_subnet.*.id
  description = "List of private subnet IDs"
}

output "cidr_block" {
  value       = var.vpc_cidr_block
  description = "The CIDR block associated with the VPC"
}

output "nat_gateway_ips" {
  value       = aws_eip.this_eip.*.public_ip
  description = "List of Elastic IPs associated with NAT gateways"
}
