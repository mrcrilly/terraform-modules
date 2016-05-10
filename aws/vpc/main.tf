
resource "aws_vpc" "primary" {
  cidr_block = "${var.in_vpc_cidr}"

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
