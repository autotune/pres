resource "aws_security_group" "prod-apse2" {
  provider = "aws.ap-southeast-2"  
  vpc_id = "${aws_vpc.prod-apse2.id}"
  name = "prod-apse2"
  description = "Allow all inbound traffic"

  ingress { 
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { 
      from_port = 443 
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      # CHANGE ME
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1" 
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "prod-apse2-rds" {
  provider = "aws.ap-southeast-2"
  vpc_id = "${aws_vpc.prod-apse2.id}"
  name = "prod-apse2-rds"
  description = "${var.domain} RDS Traffic"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/24"]
  }
}

resource "aws_security_group" "prod-apse2-elb" {
  provider = "aws.ap-southeast-2"
  vpc_id = "${aws_vpc.prod-apse2.id}"
  name = "prod-apse2-elb"
  description = "Allow all inbound traffic"

  ingress { 
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { 
      from_port = 443 
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      # CHANGE ME
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1" 
      cidr_blocks = ["0.0.0.0/0"]
  }
}
