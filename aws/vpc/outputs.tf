
output "vpc_id" {
  value = "${aws_vpc.primary.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.primary.cidr_block}"
}
