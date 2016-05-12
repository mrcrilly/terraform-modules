
resource "aws_subnet" "management_ssh_bastions" {
  vpc_id = "${var.vpc_id}"
  map_public_ip_on_launch = true

  tags {
    Name = "management_ssh_bastions"
  }

  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, var.subnet_cidr)}"
}

resource "aws_route_table_association" "management_ssh_bastions" {
    subnet_id = "${aws_subnet.management_ssh_bastions.id}"
    route_table_id = "${var.routing_table_id}"
}

resource "aws_network_acl" "management_ssh_bastions" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "management_ssh_bastions"
  }

  subnet_ids = [
    "${aws_subnet.management_ssh_bastions.id}"
  ]

  ingress {
    rule_no = 1
    protocol = "tcp"
    action = "deny"
    cidr_block = "${var.vpc_cidr}"
    from_port = 22
    to_port = 22
  }

  ingress {
    rule_no = 2
    protocol = "tcp"
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 22
    to_port = 22
  }

  egress {
    rule_no = 3
    protocol = "all"
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
}