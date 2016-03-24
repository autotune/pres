resource "aws_ami_from_instance" "apses2" {
    provider = "aws.ap-southeast-2"
    name = "apses2-ami"
    source_instance_id = "${aws_instance.prod_pub_apses2.id}"
    depends_on = ["aws_instance.prod_pub_apses2"]
}
