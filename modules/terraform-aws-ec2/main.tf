



resource "aws_security_group" "ec2_sg" {
  name        = "ec2-http-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
#   egress {
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = [var.db_security_group_id]
#     description     = "Allow outbound MySQL traffic to DB SG"
#   }
 }


resource "aws_instance" "public_instances" {
  count                       = var.public_instance
  ami                         = "ami-0e35ddab05955cf57"
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnet_ids[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids       = [aws_security_group.ec2_sg.id]
  
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    delete_on_termination = true
  }
 iam_instance_profile = var.iam_instance_profile_name
   user_data = <<-EOF
               #!/bin/bash
                sudo apt-get update -y
                sudo apt install unzip
                sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                sudo unzip awscliv2.zip
                sudo ./aws/install
                EOF

  tags = {
    Name = "Public-Instance-Prakash"
    Environment = "Data_Base_Instance"
  }
}

