output "instance_ids" {
  value = "${join(",", aws_instance.ssh_bastion.*.id)}"
}