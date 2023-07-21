output "prometheus_server_ip" {
  value = aws_instance.monitoring.public_ip
}

output "key" {
  value = aws_key_pair.monitoring.public_key
}