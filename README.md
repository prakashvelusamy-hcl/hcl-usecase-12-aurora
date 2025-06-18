## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ./modules/terraform-aws-ec2 | n/a |
| <a name="module_iam_instance_profile"></a> [iam\_instance\_profile](#module\_iam\_instance\_profile) | ./modules/terraform-aws-instance-profile | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ./modules/terraform-aws-rds | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/terraform-aws-vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | n/a | yes |
| <a name="input_nat_count"></a> [nat\_count](#input\_nat\_count) | Number of NAT gateways | `number` | n/a | yes |
| <a name="input_priv_sub_count"></a> [priv\_sub\_count](#input\_priv\_sub\_count) | Number of private subnets | `number` | n/a | yes |
| <a name="input_pub_sub_count"></a> [pub\_sub\_count](#input\_pub\_sub\_count) | Number of public subnets | `number` | n/a | yes |
| <a name="input_public_instance"></a> [public\_instance](#input\_public\_instance) | Number of public EC2 instances to create | `number` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ids"></a> [instance\_ids](#output\_instance\_ids) | n/a |
| <a name="output_instance_public_ips"></a> [instance\_public\_ips](#output\_instance\_public\_ips) | n/a |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | n/a |
| <a name="output_my_vpc_id"></a> [my\_vpc\_id](#output\_my\_vpc\_id) | n/a |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
