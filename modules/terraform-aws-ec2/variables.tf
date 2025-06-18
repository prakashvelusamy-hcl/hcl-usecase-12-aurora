variable "public_instance" {
  description = "Number of public EC2 instances to create"
  type        = number
}
variable "public_subnet_ids" {
  description = "List of public subnet IDs to launch EC2 instances into"
  type        = list(string)
}
variable "vpc_id" {
  description = "VPC ID to use for EC2 instances and security groups"
  type        = string
}
variable "iam_instance_profile_name" {
  description = "The iam_instance_profile_name for accessing the secret"
  type = string
}
# variable "db_security_group_id" {
#   description  = "The Aurora SG ID"
#   type = string
# }