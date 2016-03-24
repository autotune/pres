resource "aws_elb" "prod" {
  provider = "aws.ap-southeast-1"
  subnets = ["${aws_subnet.prod.id}"]
  security_groups = ["${aws_security_group.prod-elb.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

   health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }

  instances = ["${aws_instance.prod_pub_apses1.id}"]
}
