output "out_subnet_id" {
  value = "${aws_subnet.public_mongodb.id}"
}

output "out_subnet_cidr" {
  value = "${aws_subnet.public_mongodb.cidr_block}"
}