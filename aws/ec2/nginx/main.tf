resource "aws_instance" "nginx" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.nginx_http.id}",
    "${aws_security_group.nginx_https.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "nginx-${count.index}"
  }
}

resource "aws_security_group" "nginx_http" {
  vpc_id = "${var.vpc_id}"
  name = "nginx_http"
  description = "nginx http"

  tags = {
    Name = "nginx http"
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}

resource "aws_security_group" "nginx_https" {
  vpc_id = "${var.vpc_id}"
  name = "nginx_https"
  description = "nginx https"

  tags = {
    Name = "nginx https"
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["${split(",", var.permitted_cidr_blocks)}"]
  }
}
