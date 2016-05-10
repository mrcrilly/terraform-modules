output "out_subnet_id" {
  value = "${aws_subnet.public_loadbalancer.id}"
}

output "out_subnet_cidr" {
  value = "${aws_subnet.public_loadbalancer.cidr_block}"
}