
resource "aws_subnet" "public_loadbalancer" {
  vpc_id = "${var.in_vpc_id}"

  tags {
    Name = "public_loadbalancer"
  }

  cidr_block = "${cidrsubnet(var.in_vpc_cidr, 8, var.in_subnet_cidr)}"
}

resource "aws_network_acl" "public_loadbalancer" {
  vpc_id = "${var.in_vpc_id}"

  tags = {
    Name = "public_loadbalancer"
  }

  subnet_ids = [
    "${aws_subnet.public_loadbalancer.id}"
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