resource "aws_security_group" "prod" {
  provider = "aws.ap-southeast-1"  
  vpc_id = "${aws_vpc.prod.id}"
  name = "prod"
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

resource "aws_security_group" "prod-rds" {
  provider = "aws.ap-southeast-1"
  vpc_id = "${aws_vpc.prod.id}"
  name = "prod-rds"
  description = "${var.domain} RDS Traffic"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/24"]
  }
}

resource "aws_security_group" "prod-elb" {
  provider = "aws.ap-southeast-1"
  vpc_id = "${aws_vpc.prod.id}"
  name = "prod-elb"
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
