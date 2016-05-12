resource "aws_vpc" "primary" {
  cidr_block = "${var.cidr}"

  tags {
    Name = "Primary"
  }
}

resource "aws_internet_gateway" "primary" {
  vpc_id = "${aws_vpc.primary.id}"

  tags {
    Name = "Primary"
  }
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.primary.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.primary.id}"
    }

    tags {
        Name = "Public"
    }
}

resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.primary.id}"

    tags {
        Name = "Private"
    }
}