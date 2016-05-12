
output "id" {
  value = "${aws_vpc.primary.id}"
}

output "cidr_block" {
  value = "${aws_vpc.primary.cidr_block}"
}

output "public_rt_id" {
  value = "${aws_route_table.public.id}"
}

output "private_rt_id" {
  value = "${aws_route_table.private.id}"
}