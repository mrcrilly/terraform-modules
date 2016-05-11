resource "aws_instance" "mariadb" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.mariadb.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "mariadb-${count.index}"
  }
}

resource "aws_security_group" "mariadb" {
  vpc_id = "${var.vpc_id}"
  name = "mariadb"
  description = "mariadb"

  tags = {
    Name = "mariadb"
  }

  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}
