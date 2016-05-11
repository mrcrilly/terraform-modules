
output "id" {
  value = "${aws_vpc.primary.id}"
}

output "cidr_block" {
  value = "${aws_vpc.primary.cidr_block}"
}
