output "id" {
  value = "${aws_subnet.management_backups.id}"
}

output "cidr_block" {
  value = "${aws_subnet.management_backups.cidr_block}"
}