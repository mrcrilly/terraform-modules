resource "aws_instance" "elasticsearch" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.elasticsearch_9300.id}",
    "${aws_security_group.elasticsearch_9200.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "elasticsearch-${count.index}"
  }
}

resource "aws_security_group" "elasticsearch_9300" {
  vpc_id = "${var.vpc_id}"
  name = "elasticsearch_9300"
  description = "elasticsearch 9300 cluster protocol"

  tags = {
    Name = "elasticsearch 9300 cluster"
  }

  ingress {
      from_port = 9300
      to_port = 9300
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}

resource "aws_security_group" "elasticsearch_9200" {
  vpc_id = "${var.vpc_id}"
  name = "elasticsearch_9200"
  description = "elasticsearch 9200 api"

  tags = {
    Name = "elasticsearch 9200 api"
  }

  ingress {
      from_port = 9200
      to_port = 9200
      protocol = "tcp"
      cidr_blocks = ["${split(",", var.permitted_cidr_blocks)}"]
  }
}
