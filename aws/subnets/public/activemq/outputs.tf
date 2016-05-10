output "out_subnet_id" {
  value = "${aws_subnet.public_activemq.id}"
}

output "out_subnet_cidr" {
  value = "${aws_subnet.public_activemq.cidr_block}"
}