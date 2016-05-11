# Networking
variable "vpc_id" {}
variable "subnet_id" {}
variable "ssh_sg_id" {}

# This needs to be a string of CIDR blocks
# in a semi-colon separated fashion.
# Example: 10.1.2.3;10.2.2.3;10.3.2.3
variable "permitted_cidr_blocks" {}

# EC2 instance
variable "count" {}
variable "ami" {}
variable "type" {}
variable "ssh_key" {}