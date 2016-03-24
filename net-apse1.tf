resource "aws_vpc" "prod" {
    provider = "aws.ap-southeast-1"
    cidr_block = "10.0.0.0/16"
    
    tags {
        Name = "public-${var.domain}"
    }
}

resource "aws_internet_gateway" "prod" {
    provider = "aws.ap-southeast-1"
    vpc_id = "${aws_vpc.prod.id}"
    
    tags {
        Name = "prod"
    }
}

resource "aws_subnet" "prod" {
    provider = "aws.ap-southeast-1"
    vpc_id = "${aws_vpc.prod.id}"
    availability_zone = "ap-southeast-1a"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    tags {
        Name = "prod"
    }
}

resource "aws_subnet" "prod-2" {
    provider = "aws.ap-southeast-1"
    vpc_id = "${aws_vpc.prod.id}"
    availability_zone = "ap-southeast-1b"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    tags {
        Name = "prod-2"
    }
}
resource "aws_route_table" "prod" {
    provider = "aws.ap-southeast-1"
    vpc_id = "${aws_vpc.prod.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.prod.id}"
    }
    tags {
        Name = "${var.domain}"
    }
}

resource "aws_route_table_association" "prod-pubnet" {
    provider = "aws.ap-southeast-1"
    subnet_id = "${aws_subnet.prod.id}"
    route_table_id = "${aws_route_table.prod.id}"
}

resource "aws_db_subnet_group" "prod" {
    provider = "aws.ap-southeast-1"
    name = "main"
    description = "Our main group of subnets"
    subnet_ids = ["${aws_subnet.prod.id}", "${aws_subnet.prod-2.id}"]
    tags {
        Name = "${var.domain} DB subnet group"
    }
}
