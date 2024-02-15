variable "ami_id" {}
variable "instance_type" {}
variable "ec2_sg_name" {}
variable "subnet_id" {}
variable "enable_public_ip_addrs" {}
variable "user_data_install_flask" {}
variable "key_name" {}
variable "tag_name" {}
variable "public_key" {}
variable "ec2_sg_name_for_python_api" {}

output "ec2_flask_id" {
  value = aws_instance.ec2_flask.id
}

resource "aws_instance" "ec2_flask" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.ec2_sg_name, var.ec2_sg_name_for_python_api]
  associate_public_ip_address = var.enable_public_ip_addrs
  user_data = var.user_data_install_flask
  key_name = var.key_name
  tags = {
    Name = var.tag_name
  }
}

resource "aws_key_pair" "ec2_instance_public_key" {
  key_name = var.key_name
  public_key = var.public_key
}