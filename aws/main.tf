# This is primarily for running tests, but it also acts
# as an example for review and learning.

module "vpc" {
  source = "./vpc"
  cidr = "10.1.0.0/16"
}

module "bastion_subnet" {
  source = "./subnets/management/ssh"
  in_vpc_id = "${module.vpc.id}"
  in_vpc_cidr = "10.1.0.0/16"
  in_subnet_cidr = "1"
}

module "bastion_security_group" {
  source = "./firewalls/security_groups/ssh"
  vpc_id = "${module.vpc.id}"
  permitted_cidr_blocks = "0.0.0.0/0;10.1.0.0/16"
}

module "gateway_subnet" {
  source = "./subnets/public/loadbalancer"
  in_vpc_id = "${module.vpc.id}"
  in_vpc_cidr = "10.1.0.0/16"
  in_subnet_cidr = "2"
}

module "gateway_servers" {
  source = "./ec2/haproxy"
  vpc_id = "${module.vpc.id}"
  subnet_id = "${module.gateway_subnet.id}"
  ssh_sg_id = "${module.bastion_security_group.id}"
  permitted_cidr_blocks = "0.0.0.0/0"
  count = "2"
  ami = "ami-fedafc9d" # CentOS 7 in Sydney
  type = "t2.micro"
  ssh_key = ""
}

module "bastion_servers" {
  source = "./ec2/ssh_bastion"
  vpc_id = "${module.vpc.id}"
  subnet_id = "${module.gateway_subnet.id}"
  permitted_cidr_blocks = "0.0.0.0/0"
  count = "2"
  ami = "ami-fedafc9d" # CentOS 7 in Sydney
  type = "t2.micro"
  ssh_key = ""
}

