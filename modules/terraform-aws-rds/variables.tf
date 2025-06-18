variable "private_subnet_group_name" {
  type        = string
  description = "Private Subnet_name"
}
variable "vpc_security_group_id" {
  type        = list(string)
  description = "The VPC secuity group ID"
}
variable "vpc_id" {
  type = string
  description = "The vpc Id"
  
}