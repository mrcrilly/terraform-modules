resource "aws_instance" "activemq" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.activemq_openwire.id}",
    "${aws_security_group.activemq_stomp.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "ActiveMQ-${count.index}"
  }
}

resource "aws_security_group" "activemq_openwire" {
  vpc_id = "${var.vpc_id}"
  name = "activemq_openwire"
  description = "ActiveMQ Openwire line protocol"

  tags = {
    Name = "ActiveMQ Openwire"
  }

  ingress {
      from_port = 61612
      to_port = 61612
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}

resource "aws_security_group" "activemq_stomp" {
  vpc_id = "${var.vpc_id}"
  name = "activemq_stomp"
  description = "ActiveMQ STOMP line protocol"

  tags = {
    Name = "ActiveMQ STOMP"
  }

  ingress {
      from_port = 61616
      to_port = 61616
      protocol = "tcp"
      cidr_blocks = ["${split(",", var.permitted_cidr_blocks)}"]
  }
}
