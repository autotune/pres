resource "aws_instance" "prod_pub_apses1" {
  provider = "aws.ap-southeast-1"
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The  username for our AMI
    user = "centos"
    key_file = "~/.ssh/id_rsa"

    # The connection will use the local SSH agent for authentication.
  }

  instance_type = "t2.micro"
  tags {
      Name = "prod_pub_web1"
      Net  = "Public"
  }
  # Lookup the correct AMI based on the region
  # we specified
  ami = "ami-106aa373"

  # The name of our SSH keypair we created above.
  key_name = "${var.keyname}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.prod.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.prod.id}"

  provisioner "local-exec" {
      command="echo \"wp_db_hostname: ${aws_db_instance.apse1.address}\" > ./wordpress-nginx-1/group_vars/localhost"
  }

  provisioner "file" {
        source = "./wordpress-nginx-1"
        destination = "~/wordpress-nginx"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo service iptables stop",
      "sudo cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime",
      "sudo yum clean all",
      "sudo yum install epel-release.noarch -y",
      "sudo yum install gcc gmp-devel python-pip python-devel -y",
      "sudo pip install ansible"
    ]
  }

  provisioner "remote-exec" {
    inline = [ 
      "ansible-playbook -c local ~/wordpress-nginx/site.yml"
    ]
  }
  
  depends_on = ["aws_db_instance.apse1"]
}

