resource "aws_ami_from_instance" "apses1" {
    provider = "aws.ap-southeast-1"
    name = "apses1-ami"
    source_instance_id = "${aws_instance.prod_pub_apses1.id}"
    depends_on = ["aws_instance.prod_pub_apses1"]
}
