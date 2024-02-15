variable "db_subnet_group_name" {}
variable "subnet_groups" {}
variable "rds_mysql_sg_id" {}
variable "mysql_db_identifier" {}
variable "mysql_username" {}
variable "mysql_password" {}
variable "mysql_dbname" {}



resource "aws_db_subnet_group" "devops-prj-db-subnet_grp" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_groups
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = var.mysql_db_identifier
  username             = var.mysql_username
  password             = var.mysql_password
  db_name              = var.mysql_dbname
  vpc_security_group_ids  = [var.rds_mysql_sg_id]
  db_subnet_group_name    = aws_db_subnet_group.devops-prj-db-subnet_grp.name
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot     = true
  apply_immediately       = true
  backup_retention_period = 0
  deletion_protection     = false
}