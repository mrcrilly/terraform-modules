output "id" {
  value = "${aws_subnet.management_logstash.id}"
}

output "cidr_block" {
  value = "${aws_subnet.management_logstash.cidr_block}"
}