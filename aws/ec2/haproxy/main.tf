resource "aws_instance" "haproxy" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.haproxy_http.id}",
    "${aws_security_group.haproxy_https.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "haproxy-${count.index}"
  }
}

resource "aws_security_group" "haproxy_http" {
  vpc_id = "${var.vpc_id}"
  name = "haproxy_http"
  description = "haproxy http"

  tags = {
    Name = "haproxy http"
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}

resource "aws_security_group" "haproxy_https" {
  vpc_id = "${var.vpc_id}"
  name = "haproxy_https"
  description = "haproxy https"

  tags = {
    Name = "haproxy https"
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["${split(",", var.permitted_cidr_blocks)}"]
  }
}
