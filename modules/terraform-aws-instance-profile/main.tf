resource "aws_iam_role" "ec2_role" {
  name = "ec2-secrets-access-role-prakash"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_policy" "ec2_secrets_policy" {
  name        = "ec2-secrets-access-policy-prakash"
  description = "Allows EC2 instance to read Secrets Manager secrets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = "arn:aws:secretsmanager:ap-south-1:495599733393:secret:PrakashMyDBSecret-71ek01"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "attach_secrets_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_secrets_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile-prakash"
  role = aws_iam_role.ec2_role.name
}