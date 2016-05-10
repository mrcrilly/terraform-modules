
resource "aws_subnet" "management_influxdb" {
  vpc_id = "${var.in_vpc_id}"

  tags {
    Name = "management_influxdb"
  }

  cidr_block = "${cidrsubnet(var.in_vpc_cidr, 8, vars.in_subnet_cidr)}"
}

resource "aws_network_acl" "management_influxdb" {
  vpc_id = "${var.in_vpc_id}"

  tags = {
    Name = "management_influxdb"
  }

  subnet_ids = [
    "${aws_subnet.management_influxdb.id}"
  ]

  ingress {
    rule_no = 1
    protocol = "tcp"
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1
    to_port = 65535
  }

  ingress {
    rule_no = 2
    protocol = "udp"
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1
    to_port = 65535
  }

  egress {
    rule_no = 2
    protocol = "tcp"
    action = "allow"
    cidr_block = "${var.in_vpc_cidr}"
    from_port = 1
    to_port = 22
  }
}