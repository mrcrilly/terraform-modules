output "instance_ids" {
  value = "${join(",", module.aws_instance.activemq)}"
}