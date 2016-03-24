resource "aws_elb" "prod-apse2" {
  provider = "aws.ap-southeast-2"
  subnets = ["${aws_subnet.prod-apse2.id}"]
  security_groups = ["${aws_security_group.prod-apse2-elb.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  instances = ["${aws_instance.prod_pub_apses2.id}"]
