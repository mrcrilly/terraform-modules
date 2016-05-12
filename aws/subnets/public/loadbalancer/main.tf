
resource "aws_subnet" "public_loadbalancer" {
  vpc_id = "${var.in_vpc_id}"
  map_public_ip_on_launch = true

  tags {
    Name = "public_loadbalancer"
  }

  cidr_block = "${cidrsubnet(var.in_vpc_cidr, 8, var.in_subnet_cidr)}"
}

resource "aws_route_table_association" "public_loadbalancer" {
    subnet_id = "${aws_subnet.public_loadbalancer.id}"
    route_table_id = "${var.routing_table_id}"
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
    from_port = 443
    to_port = 443
  }

  ingress {
    rule_no = 2
    protocol = "tcp"
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 80
    to_port = 80
  }

  ingress {
    rule_no = 3
    protocol = "tcp"
    action = "allow"
    cidr_block = "${var.bastion_cidr}"
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