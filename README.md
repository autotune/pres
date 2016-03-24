#### TERRAFORM DOCUMENTATION
https://www.terraform.io/docs/providers/aws/index.html

#### CENTOS AMIs
https://wiki.centos.org/Cloud/AWS

#### COMMANDS USED
terraform destroy -target=aws_autoscaling_group.apses1
terraform destroy -target=aws_autoscaling_group.apses2
terraform apply -target=aws_instance.prod_pub_apses2
terraform apply -target=aws_launch_configuration.apses2
terraform apply -target=aws_autoscaling_group.apses2


pilot_launch.sh 
===============
find . -name "*.pilot" -exec rename 's/.pilot$/.pilot.tf/' {} \;

pilot_destroy.sh
===============
find . -name "*.pilot.tf" -exec rename 's/.pilot.tf$/.pilot/' {} \;

terraform destroy -target=aws_instance.prod_pub_apses1
terraform apply -target=aws_instance.prod_pub_apses1

#### LINKS

http://github.com/autotune/wiki/terraform
http://terraform.io 

#### GOTCHAS

TF_LOG=DEBUG
resource limits                     
RDS Creation Time (grab some tea)
Provision Failure                 
ARN for replicate_source_db   
Security Groups vs Rules TF_LOG=DEBUG
