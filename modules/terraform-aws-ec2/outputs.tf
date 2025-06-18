output "public_instance_ids" {
  description = "List of EC2 instance IDs for public instances"
  value       = aws_instance.public_instances[*].id
}

output "public_instance_ips" {
  description = "List of public IP addresses for the public instances"
  value       = aws_instance.public_instances[*].public_ip
}

output "ec2_security_group_id" {
value = aws_security_group.ec2_sg.id 
}
