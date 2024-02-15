provider "aws" {
  region = "eu-central-1"
}

module "networking" {
  source = "./infra/networking"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  public_subnet = var.public_subnet
  private_subnet = var.private_subnet
  eu_availability_zone = var.eu_availability_zone
}

module "security_group" {
  source = "./infra/security-groups"
  vpc_id = module.networking.vpc_id
  ec2_sg_name = var.ec2_sg_name
  ec2_sg_name_for_python_api = "SG for EC2 for enabling port 5000"
}

module "ec2" {
  source = "./infra/ec2"
  public_key = var.public_key
  instance_type = "t2.micro"
  key_name = "jenkins"
  subnet_id = tolist(module.networking.public_subnet_id)[0]
  ec2_sg_name = module.security_group.security_group_id
  ec2_sg_name_for_python_api = module.security_group.sg_ec2_for_python_api
  tag_name = "Flask:Ubuntu Linux EC2"
  ami_id = var.ec2_ami_id
  enable_public_ip_addrs = true
  user_data_install_flask = templatefile("./infra/template/ec2_install_apache.sh",{})
}

module "lb_target_group_and_attachment" {
  source = "./infra/lb-target-grp"
  vpc_id = module.networking.vpc_id
  lb_target_group_port = 5000
  lb_target_group_protocol = "HTTP"
  lb_target_group_name = "flask-lb-target-group"
  ec2_instance_id = module.ec2.ec2_flask_id
  target_grp_attachment_port = 5000
}

module "alb" {
  source = "./infra/load-balancer"
  lb_type = "application"
  subnet_ids = tolist(module.networking.public_subnet_id)
  sg_grps = module.security_group.security_group_id
  alb_name = "devops-prj-alb"
  tag_name = "devops-prj-alb"
  is_external = false
  alb-http_listener_port = 80
  alb-http_listener_protocol = "HTTP"
  alb-http_listener_type = "forward"
  alb_target_group_arn = module.lb_target_group_and_attachment.devops-prj-target_grp_arn
}

module "rds_db_instance" {
  source = "./infra/rds"
  db_subnet_group_name = "devops-prj-rds-subnet_group"
  subnet_groups = tolist(module.networking.private_subnet_id)
  rds_mysql_sg_id = module.security_group.rds_mysql_sg_id
  mysql_db_identifier = "mydb"
  mysql_username = "dbuser"
  mysql_password = "dbpassword"
  mysql_dbname = "devopsprojdb"
}