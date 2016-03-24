resource "aws_launch_configuration" "apses1" {
    name = "-apse1"
    image_id = "${aws_ami_from_instance.apses1.id}"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    security_groups = ["${aws_security_group.prod.id}"]
}

resource "aws_autoscaling_group" "apses1" {
  availability_zones = ["ap-southeast-1a"]
  name = "${var.domain}-asg"
  max_size = 5
  min_size = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  desired_capacity = 1
  force_delete = true
  launch_configuration = "${aws_launch_configuration.apses1.name}"
  vpc_zone_identifier = ["${aws_subnet.prod.id}"]
  load_balancers = ["${aws_elb.prod.id}"]
  tag {
    key = "Name"
    value = "${var.domain}.asg"
    propagate_at_launch = true
  }
}
