output "out_subnet_id" {
  value = "${aws_subnet.management_logstash.id}"
}

output "out_subnet_cidr" {
  value = "${aws_subnet.management_logstash.cidr_block}"
}