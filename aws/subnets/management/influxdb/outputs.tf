output "out_subnet_id" {
  value = "${aws_subnet.management_influxdb.id}"
}

output "out_subnet_cidr" {
  value = "${aws_subnet.management_influxdb.cidr_block}"
}