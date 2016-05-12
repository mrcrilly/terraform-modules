resource "aws_instance" "ssh_bastion" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.ssh_bastion.id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "ssh_bastion-${count.index}"
  }
}

resource "aws_security_group" "ssh_bastion" {
  vpc_id = "${var.vpc_id}"
  name = "ssh_bastion"
  description = "ssh_bastion"

  tags = {
    Name = "ssh_bastion"
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}