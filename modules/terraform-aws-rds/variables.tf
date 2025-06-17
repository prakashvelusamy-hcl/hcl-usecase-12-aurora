variable "private_subnet_group_name" {
  type        = string
  description = "Private Subnet_name"
}
variable "vpc_security_group_id" {
  type        = list(string)
  description = "The VPC secuity group ID"
}