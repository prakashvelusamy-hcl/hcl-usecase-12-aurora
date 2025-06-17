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
        Resource = aws_secretsmanager_secret.db_credentials.arn
      }
    ]
  })
}


resource "aws_iam_role" "app_role" {
  name = "app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole",
        Condition = {
          "StringEquals" = {
            "aws:ResourceTag/Environment" = "Data_Base_Instance"
          }
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_secret_policy" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.read_db_secret.arn
}