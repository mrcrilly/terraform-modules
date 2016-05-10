output "out_subnet_id" {
  value = "${aws_subnet.management_ssh_bastions.id}"
}

output "out_subnet_cidr" {
  value = "${aws_subnet.management_ssh_bastions.cidr_block}"
}