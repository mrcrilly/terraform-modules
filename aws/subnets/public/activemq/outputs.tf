output "id" {
  value = "${aws_subnet.public_activemq.id}"
}

output "cidr_block" {
  value = "${aws_subnet.public_activemq.cidr_block}"
}