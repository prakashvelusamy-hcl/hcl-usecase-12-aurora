output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}
output "private_subnet_group_name" {
  value = aws_db_subnet_group.private.name
}
output "vpc_security_group_id" {
  value = data.aws_security_group.vpc.id

}