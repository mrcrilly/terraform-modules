resource "aws_instance" "influxdb" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.influxdb_http.id}",
    "${aws_security_group.influxdb_admin.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "influxdb-${count.index}"
  }
}

resource "aws_security_group" "influxdb_http" {
  vpc_id = "${var.vpc_id}"
  name = "influxdb_http"
  description = "influxdb http"

  tags = {
    Name = "influxdb http"
  }

  ingress {
      from_port = 8086
      to_port = 8086
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}

resource "aws_security_group" "influxdb_admin" {
  vpc_id = "${var.vpc_id}"
  name = "influxdb_admin"
  description = "influxdb admin"

  tags = {
    Name = "influxdb admin"
  }

  ingress {
      from_port = 8083
      to_port = 8083
      protocol = "tcp"
      cidr_blocks = ["${split(",", var.permitted_cidr_blocks)}"]
  }
}
