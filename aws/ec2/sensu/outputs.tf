output "instance_ids" {
  value = "${join(",", aws_instance.sensu.*.id)}"
}