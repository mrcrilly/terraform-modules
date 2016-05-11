output "instance_ids" {
  value = "${join(",", aws_instance.elasticsearch.*.id)}"
}