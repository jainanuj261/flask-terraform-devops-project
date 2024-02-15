variable "ec2_sg_name" {}
variable "vpc_id" {}
variable "ec2_sg_name_for_python_api" {}

output "security_group_id" {
  value = aws_security_group.ec2_sg_ssh_http.id
}

output "sg_ec2_for_python_api" {
  value = aws_security_group.ec2_sg_python_api.id

}

output "rds_mysql_sg_id" {
  value = aws_security_group.rds_mysql_sg.id
}

resource "aws_security_group" "ec2_sg_ssh_http" {
  vpc_id = var.vpc_id
  name = var.ec2_sg_name

  ingress {
    description = "Allow remote ssh from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  ingress {
    description = "Allow HTTP from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  
  #Outgoing request
  egress {
    description = "Allow outgoing request"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = var.ec2_sg_name
  }

}

resource "aws_security_group" "ec2_sg_python_api" {
  name        = var.ec2_sg_name_for_python_api
  description = "Enable the Port 5000 for python api"
  vpc_id      = var.vpc_id

  # ssh for terraform remote exec
  ingress {
    description = "Allow traffic on port 5000"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
  }

  tags = {
    Name = "Security Groups to allow traffic on port 5000"
  }
}

resource "aws_security_group" "rds_mysql_sg" {
  name        = "rds-sg"
  description = "Allow access to RDS from EC2 present in public subnet"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"] # replace with your EC2 instance security group CIDR block
  }
}