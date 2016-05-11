resource "aws_instance" "mongodb" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.mongodb_27017.id}",
    "${aws_security_group.mongodb_28017.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "mongodb-${count.index}"
  }
}

resource "aws_security_group" "mongodb_27017" {
  vpc_id = "${var.vpc_id}"
  name = "mongodb_27017"
  description = "mongodb 27017"

  tags = {
    Name = "mongodb 27017"
  }

  ingress {
      from_port = 27017
      to_port = 27017
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}

resource "aws_security_group" "mongodb_28017" {
  vpc_id = "${var.vpc_id}"
  name = "mongodb_28017"
  description = "mongodb 28017"

  tags = {
    Name = "mongodb 28017"
  }

  ingress {
      from_port = 28017
      to_port = 28017
      protocol = "tcp"
      cidr_blocks = ["${split(",", var.permitted_cidr_blocks)}"]
  }
}
