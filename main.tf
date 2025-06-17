
module "vpc" {
  source         = "./modules/terraform-aws-vpc"
  vpc_cidr       = var.vpc_cidr
  pub_sub_count  = var.pub_sub_count
  priv_sub_count = var.priv_sub_count
  nat_count      = var.nat_count
  environment    = var.environment
}
module "ec2" {
  source            = "./modules/terraform-aws-ec2"
  public_instance   = var.public_instance
  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
}

module "rds" {
  source                    = "./modules/terraform-aws-rds"
  private_subnet_group_name = module.vpc.private_subnet_group_name
  vpc_security_group_id     = [module.vpc.vpc_security_group_id]
}
module "secrets" {
  source                    = "./modules/terraform-aws-secrets"
}