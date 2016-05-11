output "id" {
  value = "${aws_subnet.public_mongodb.id}"
}

output "cidr_block" {
  value = "${aws_subnet.public_mongodb.cidr_block}"
}