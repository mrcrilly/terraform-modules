output "id" {
  value = "${aws_subnet.management_ssh_bastions.id}"
}

output "cidr_block" {
  value = "${aws_subnet.management_ssh_bastions.cidr_block}"
}