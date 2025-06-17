# resource "aws_db_instance" "default" {
#   allocated_storage       = 10
#   storage_type            = "gp2"
#   engine                  = "mysql"
#   engine_version          = "5.7"
#   instance_class          = "db.t3.micro"
#   identifier              = "mydb"
#   username                = "dbuser"
#   password                = "dbpassword"
#   availability_zone       = "ap-south-1a"
#   backup_retention_period = 7

#   #vpc_security_group_ids = [aws_security_group.rds_sg.id]
#   vpc_security_group_ids = var.vpc_security_group_id
#   db_subnet_group_name   = var.private_subnet_group_name
#   publicly_accessible    = false
#   skip_final_snapshot    = true
# }



resource "aws_rds_cluster" "default" {
  allocated_storage       = 10
  cluster_identifier      = "aurora-cluster-test"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = ["ap-south-1a"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  vpc_security_group_ids = var.vpc_security_group_id
  db_subnet_group_name   = var.private_subnet_group_name

}



resource "aws_secretsmanager_secret" "db_credentials" {
  name = "aurora-db-credentials"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "prakash"
    password = "prakash-secret"
  })
}

# resource "aws_db_instance" "read_replica" {
#   #   replicate_source_db = aws_db_instance.default.id
#   replicate_source_db     = aws_db_instance.default.arn
#   instance_class          = "db.t3.micro"
#   publicly_accessible     = false
#   availability_zone       = "ap-south-1b"
#   identifier              = "mydb-replica"
#   db_subnet_group_name    = var.private_subnet_group_name
#   vpc_security_group_ids  = var.vpc_security_group_id
#   depends_on              = [aws_db_instance.default]
#   backup_retention_period = 7
#   skip_final_snapshot     = true
# }
