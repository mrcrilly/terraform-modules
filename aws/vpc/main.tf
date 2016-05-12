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