output "id" {
  value = "${aws_subnet.management_influxdb.id}"
}

output "cidr_block" {
  value = "${aws_subnet.management_influxdb.cidr_block}"
}