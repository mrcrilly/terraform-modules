resource "aws_instance" "relay" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.relay.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "relay-${count.index}"
  }
}

resource "aws_security_group" "relay" {
  vpc_id = "${var.vpc_id}"
  name = "relay"
  description = "relay"

  tags = {
    Name = "relay"
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}
