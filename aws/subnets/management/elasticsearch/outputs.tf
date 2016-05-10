output "out_subnet_id" {
  value = "${aws_subnet.management_backups.id}"
}

output "out_subnet_cidr" {
  value = "${aws_subnet.management_backups.cidr_block}"
}