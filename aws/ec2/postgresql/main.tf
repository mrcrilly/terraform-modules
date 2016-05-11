resource "aws_instance" "postgresql" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.postgresql.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "postgresql-${count.index}"
  }
}

resource "aws_security_group" "postgresql" {
  vpc_id = "${var.vpc_id}"
  name = "postgresql"
  description = "postgresql"

  tags = {
    Name = "postgresql"
  }

  ingress {
      from_port = 5432
      to_port = 5432
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}
