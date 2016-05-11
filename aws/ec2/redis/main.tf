resource "aws_instance" "redis" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.redis.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "redis-${count.index}"
  }
}

resource "aws_security_group" "redis" {
  vpc_id = "${var.vpc_id}"
  name = "redis"
  description = "redis"

  tags = {
    Name = "redis"
  }

  ingress {
      from_port = 6379
      to_port = 6379
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}
