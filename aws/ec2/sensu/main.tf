resource "aws_instance" "sensu" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.sensu_api.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "sensu-${count.index}"
  }
}

resource "aws_security_group" "sensu_api" {
  vpc_id = "${var.vpc_id}"
  name = "sensu_api"
  description = "sensu api"

  tags = {
    Name = "sensu api"
  }

  ingress {
      from_port = 4567
      to_port = 4567
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}