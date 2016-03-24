resource "aws_db_instance" "apse1" {
    provider = "aws.ap-southeast-1"
    identifier = "prod-rds1"
    # GB
    allocated_storage = 10
    engine = "mysql"
    # http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html
    engine_version = "5.6.27" 
    instance_class = "db.t2.medium"
    # encrypt this file with ansible-vault
    username = "${var.username}"
    password = "sup3r_s3cur3_phr4se_h3r3"
    backup_retention_period = 1
    db_subnet_group_name = "${aws_db_subnet_group.prod.id}" 
    vpc_security_group_ids = ["${aws_security_group.prod-rds.id}"]
} 
