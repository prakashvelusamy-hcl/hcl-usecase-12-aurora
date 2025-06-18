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

resource "aws_security_group" "db_sg" {
  name        = "Aurora DB Security Group"
  description = "Allow 3306 port"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_security_group_id]
    description     = "Allow inbound from ec2"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-test"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.04.0"
  availability_zones      = data.aws_availability_zones.az.names
  database_name           = "mydb"
  master_username         = local.db_secret.username
  master_password         = local.db_secret.password
  backup_retention_period = 5
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = var.private_subnet_group_name
  skip_final_snapshot    = true
}
resource "aws_rds_cluster_instance" "writer" {
  identifier              = "aurora-cluster-writer-instance-1"
  cluster_identifier      = aws_rds_cluster.default.id
  instance_class          = "db.t3.medium"
  engine                  = aws_rds_cluster.default.engine
  engine_version          = aws_rds_cluster.default.engine_version
  publicly_accessible     = false
  db_subnet_group_name    = var.private_subnet_group_name
  availability_zone       = data.aws_availability_zones.az.names[0]
}




# resource "aws_rds_cluster_instance" "reader" {
#   count                   = 1 
#   identifier              = "aurora-cluster-test-instance-reader-${count.index + 1}"
#   cluster_identifier      = aws_rds_cluster.default.id
#   instance_class          = "db.t3.medium"
#   engine                  = aws_rds_cluster.default.engine
#   engine_version          = aws_rds_cluster.default.engine_version
#   publicly_accessible     = false
#   db_subnet_group_name    = var.private_subnet_group_name
#   availability_zone       = data.aws_availability_zones.az.names[count.index + 1]
# }




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