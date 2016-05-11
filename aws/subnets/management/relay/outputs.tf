output "id" {
  value = "${aws_subnet.management_relay.id}"
}

output "cidr_block" {
  value = "${aws_subnet.management_relay.cidr_block}"
}