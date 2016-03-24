resource "aws_launch_configuration" "apses2" {
    provider="aws.ap-southeast-2"
    name = "-apse2-2"
    image_id = "${aws_ami_from_instance.apses2.id}"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    
}

resource "aws_autoscaling_group" "apses2" {
  provider="aws.ap-southeast-2"
  availability_zones = ["ap-southeast-2a"]
  name = "asg2-2"
  max_size = 5
  min_size = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  desired_capacity = 1
  force_delete = true
  launch_configuration = "${aws_launch_configuration.apses2.name}"
  vpc_zone_identifier = ["${aws_subnet.prod-apse2.id}"]
  load_balancers = ["${aws_elb.prod-apse2.id}"]
  tag {
    key = "Name"
    value = "asg"
    propagate_at_launch = true
  }
}
