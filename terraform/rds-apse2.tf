resource "aws_db_instance" "apse2" {
    provider = "aws.ap-southeast-2"
    identifier = "prod-rds${var.rds2}"
    # GB
    allocated_storage = 10
    engine = "mysql"
    # http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html
    engine_version = "5.6.27" 
    instance_class = "db.t2.medium"
    # encrypt this file with ansible-vault
    username = "${var.username}"
    password = "sup3r_s3cur3_phr4se_h3r3"
    db_subnet_group_name = "${aws_db_subnet_group.prod-apse2.id}" 
    vpc_security_group_ids = ["${aws_security_group.prod-apse2-rds.id}"]
    # remove to promote to master
    replicate_source_db = "${aws_db_instance.apse1.arn}"
} 
