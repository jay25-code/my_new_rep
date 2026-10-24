output "private-ips" {
value = [for instance in aws_instance.example_server : instance.private_ip]
}

output "volume-id" {
value = [for vol in aws_ebs_volume.example : vol.id]
}
