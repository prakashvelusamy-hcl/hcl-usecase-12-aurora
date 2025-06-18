data "aws_secretsmanager_secret" "db" {
  arn = "arn:aws:secretsmanager:ap-south-1:495599733393:secret:PrakashMyDBSecret-71ek01"
}

data "aws_secretsmanager_secret_version" "db_version" {
  secret_id = data.aws_secretsmanager_secret.db.id
}

locals {
  db_secret = jsondecode(data.aws_secretsmanager_secret_version.db_version.secret_string)
}

resource "aws_iam_policy" "read_db_secret" {
  name        = "ReadDBSecretPolicy"
  description = "Policy to allow read access to Aurora DB secret"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Effect   = "Allow",
        Resource = data.aws_secretsmanager_secret.db.arn
      }
    ]
  })
}

data "aws_availability_zones" "az" {
  state = "available"
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-test"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.04.0"
  availability_zones      = [data.aws_availability_zones.az.names]
  database_name           = "mydb"
  master_username         = local.db_secret.username
  master_password         = local.db_secret.password
  backup_retention_period = 5
  vpc_security_group_ids = var.vpc_security_group_id
  db_subnet_group_name   = var.private_subnet_group_name
  skip_final_snapshot    = true
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