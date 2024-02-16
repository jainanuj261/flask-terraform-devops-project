Provisioned infra using Terraform for [Flask Application](https://github.com/jainanuj261/Terraform-python-mysql-db-proj.git) using [Jenkins pipeline](https://github.com/jainanuj261/jenkins-terraform-devops-project.git)

Below are the AWS resources that have been provisioned for the Flask application and the state file has been stored in remote backend S3.

```
ajain@AJAIN-LT:~/Desktop/Terraform/flask-terraform-devops-project$ terraform state list
module.alb.aws_lb.devops-prj_alb
module.alb.aws_lb_listener.devops-prj-alb-http_listener
module.ec2.aws_instance.ec2_flask
module.ec2.aws_key_pair.ec2_instance_public_key
module.lb_target_group_and_attachment.aws_lb_target_group.devops-prj-target_grp
module.lb_target_group_and_attachment.aws_lb_target_group_attachment.devops-prj-target_grp_attachment
module.networking.aws_internet_gateway.devops-prj-vpc_public_igw
module.networking.aws_route_table.devops-prj-private_route_table
module.networking.aws_route_table.devops-prj-public_route_table
module.networking.aws_route_table_association.devops-prj-private_route_table_association[0]
module.networking.aws_route_table_association.devops-prj-private_route_table_association[1]
module.networking.aws_route_table_association.devops-prj-public_route_table_association[0]
module.networking.aws_route_table_association.devops-prj-public_route_table_association[1]
module.networking.aws_subnet.devops-prj-vpc_private_subnets[0]
module.networking.aws_subnet.devops-prj-vpc_private_subnets[1]
module.networking.aws_subnet.devops-prj-vpc_public_subnets[0]
module.networking.aws_subnet.devops-prj-vpc_public_subnets[1]
module.networking.aws_vpc.Terraform_VPC
module.rds_db_instance.aws_db_instance.default
module.rds_db_instance.aws_db_subnet_group.devops-prj-db-subnet_grp
module.security_group.aws_security_group.ec2_sg_python_api
module.security_group.aws_security_group.ec2_sg_ssh_http
module.security_group.aws_security_group.rds_mysql_sg
```

![flask-terraform-devops-eu-central-1-pipeline-Jenkins-](https://github.com/jainanuj261/flask-terraform-devops-project/assets/39861547/fda103e4-8c61-48c7-9cbc-297993f926c0)

<img width="761" alt="flask_appln" src="https://github.com/jainanuj261/flask-terraform-devops-project/assets/39861547/455d937a-bde9-4353-b012-ec44a130ba8d">



