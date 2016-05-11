output "id" {
  value = "${aws_subnet.public_loadbalancer.id}"
}

output "cidr_block" {
  value = "${aws_subnet.public_loadbalancer.cidr_block}"
}