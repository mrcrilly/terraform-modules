# This is primarily for running tests, but it also acts
# as an example for review and learning.

module "vpc" {
  source = "./vpc"
  cidr = "10.1.0.0/16"
}

module "bastion_subnet" {
  source = "./subnets/management/ssh"
  vpc_id = "${module.vpc.id}"
  vpc_cidr = "10.1.0.0/16"
  subnet_cidr = "1"
  routing_table_id = "${module.vpc.public_rt_id}"
}

resource "aws_security_group" "ssh_internal" {
  vpc_id = "${module.vpc.id}"
  name = "ssh"
  description = "SSH Access"

  tags = {
    Name = "SSH Access"
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${cidrsubnet("10.1.0.0/16", 8, 1)}"]
  }
}

module "lb_subnet" {
  source = "./subnets/public/loadbalancer"
  in_vpc_id = "${module.vpc.id}"
  in_vpc_cidr = "10.1.0.0/16"
  in_subnet_cidr = "2"
  routing_table_id = "${module.vpc.private_rt_id}"
}

module "gateway_servers" {
  source = "./ec2/haproxy"
  vpc_id = "${module.vpc.id}"
  subnet_id = "${module.lb_subnet.id}"
  ssh_sg_id = "${aws_security_group.ssh_internal.id}"
  permitted_cidr_blocks = "0.0.0.0/0"
  count = "1"
  ami = "ami-fedafc9d" # CentOS 7 in Sydney
  type = "t2.micro"
  ssh_key = "michaelc"
}

module "bastion_servers" {
  source = "./ec2/ssh_bastion"
  vpc_id = "${module.vpc.id}"
  subnet_id = "${module.bastion_subnet.id}"
  permitted_cidr_blocks = "0.0.0.0/0"
  count = "1"
  ami = "ami-fedafc9d" # CentOS 7 in Sydney
  type = "t2.micro"
  ssh_key = "michaelc"
}

