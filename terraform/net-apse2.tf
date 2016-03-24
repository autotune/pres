resource "aws_vpc" "prod-apse2" {
    provider = "aws.ap-southeast-2"
    cidr_block = "10.0.0.0/16"
    
    tags {
        Name = "public-${var.domain}"
    }
}

resource "aws_internet_gateway" "prod-apse2" {
    provider = "aws.ap-southeast-2"
    vpc_id = "${aws_vpc.prod-apse2.id}"
    
    tags {
        Name = "prod-apse2"
    }
}

resource "aws_subnet" "prod-apse2" {
    provider = "aws.ap-southeast-2"
    vpc_id = "${aws_vpc.prod-apse2.id}"
    availability_zone = "ap-southeast-2a"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    tags {
        Name = "prod-apse2"
    }
}

resource "aws_subnet" "prod-apse2-2" {
    provider = "aws.ap-southeast-2"
    vpc_id = "${aws_vpc.prod-apse2.id}"
    availability_zone = "ap-southeast-2c"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    tags {
        Name = "prod-apse2-2"
    }
}
resource "aws_route_table" "prod-apse2" {
    provider = "aws.ap-southeast-2"
    vpc_id = "${aws_vpc.prod-apse2.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.prod-apse2.id}"
    }
    tags {
        Name = "${var.domain}"
    }
}

resource "aws_route_table_association" "prod-apse2-pubnet" {
    provider = "aws.ap-southeast-2"
    subnet_id = "${aws_subnet.prod-apse2.id}"
    route_table_id = "${aws_route_table.prod-apse2.id}"
}

resource "aws_db_subnet_group" "prod-apse2" {
    provider = "aws.ap-southeast-2"
    name = "main"
    description = "Our main group of subnets"
    subnet_ids = ["${aws_subnet.prod-apse2.id}", "${aws_subnet.prod-apse2-2.id}"]
    tags {
        Name = "Wayofthesys DB subnet group"
    }
}
