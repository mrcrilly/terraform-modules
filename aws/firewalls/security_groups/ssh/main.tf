
resource "aws_security_group" "ssh" {
  vpc_id = "${var.vpc_id}"
  name = "ssh"
  description = "SSH Access"

  tags = {
    Name = "SSH Access"
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}