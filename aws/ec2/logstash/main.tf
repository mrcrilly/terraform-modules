resource "aws_instance" "logstash" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.logstash_tcp.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "logstash-${count.index}"
  }
}

resource "aws_security_group" "logstash_tcp" {
  vpc_id = "${var.vpc_id}"
  name = "logstash_tcp"
  description = "logstash tcp"

  tags = {
    Name = "logstash tcp"
  }

  ingress {
      from_port = 512
      to_port = 512
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}
