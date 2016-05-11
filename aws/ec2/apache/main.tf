resource "aws_instance" "apache" {
  count = "${var.count}"
  ami = "${var.ami}"
  instance_type = "${var.type}"
  key_name = "${var.ssh_key}"

  vpc_security_group_ids = [
    "${aws_security_group.apache_http.id}",
    "${aws_security_group.apache_https.id}",
    "${var.ssh_sg_id}"
  ]

  subnet_id = "${var.subnet_id}"

  tags {
    Name = "apache-${count.index}"
  }
}

resource "aws_security_group" "apache_http" {
  vpc_id = "${var.vpc_id}"
  name = "apache_http"
  description = "apache http"

  tags = {
    Name = "apache http"
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["${split(";", var.permitted_cidr_blocks)}"]
  }
}

resource "aws_security_group" "apache_https" {
  vpc_id = "${var.vpc_id}"
  name = "apache_https"
  description = "apache https"

  tags = {
    Name = "apache https"
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["${split(",", var.permitted_cidr_blocks)}"]
  }
}
