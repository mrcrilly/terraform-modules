output "out_subnet_id" {
  value = "${aws_subnet.management_relay.id}"
}

output "out_subnet_cidr" {
  value = "${aws_subnet.management_relay.cidr_block}"
}