resource "aws_route53_record" "www" {
    provider = "aws.ap-southeast-1"
    zone_id = "${var.domain-com-id}"
    name = "${var.domain}"
    type = "A"
    set_identifier = "prod-www-primary"
    failover = "PRIMARY"
    alias {
      name = "${aws_elb.prod.dns_name}"
      zone_id = "${aws_elb.prod.zone_id}"
      evaluate_target_health = true 
    }
}


resource "aws_route53_record" "www2" {
    provider = "aws.ap-southeast-1"
    zone_id = "${var.domain-com-id}"
    name = "${var.domain}"
    type = "A"
    set_identifier = "prod-www-secondary"
    failover = "SECONDARY"
    alias {
      name = "${aws_elb.prod-apse2.dns_name}"
      zone_id = "${aws_elb.prod-apse2.zone_id}"
        evaluate_target_health = true 
    }
}

