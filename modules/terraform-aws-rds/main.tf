data "aws_secretsmanager_secret" "db" {
  arn = "arn:aws:secretsmanager:ap-south-1:495599733393:secret:MyDBSecret-XSqocm"
}

data "aws_secretsmanager_secret_version" "db_version" {
  secret_id = data.aws_secretsmanager_secret.db.id
}

locals {
  db_secret = jsondecode(data.aws_secretsmanager_secret_version.db_version.secret_string)
}




resource "aws_rds_cluster" "default" {
  allocated_storage       = 10
  cluster_identifier      = "aurora-cluster-test"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = ["ap-south-1a"]
  database_name           = "mydb"
  master_username         = local.db_secret.username
  master_password         = local.db_secret.password
  backup_retention_period = 5
  vpc_security_group_ids = var.vpc_security_group_id
  db_subnet_group_name   = var.private_subnet_group_name

}



# resource "aws_secretsmanager_secret" "db_credentials" {
#   name = "aurora-db-credentials"
# }

# resource "aws_secretsmanager_secret_version" "db_credentials_version" {
#   secret_id     = aws_secretsmanager_secret.db_credentials.id
#   secret_string = jsonencode({
#     username = "prakash"
#     password = "prakash-secret"
#   })
# }