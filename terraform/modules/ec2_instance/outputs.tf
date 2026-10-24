output "private-ips" {
value = aws_instance.example_server[*].private_ip
}

output "volume-id" {
value = aws_ebs_volume.example[*].id
}
