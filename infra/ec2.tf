resource "aws_key_pair" "monitoring" {
  key_name   = "monitoring_server_keypair"
  public_key = file(var.instance_ssh_pub_key)
}

resource "aws_instance" "monitoring" {
  instance_type               = var.instance_type
  ami                         = var.ami_id
  subnet_id                   = aws_subnet.monitoring_a.id
  vpc_security_group_ids      = [aws_security_group.monitoring.id]
  key_name                    = aws_key_pair.monitoring.key_name
  associate_public_ip_address = true

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ec2-user -i '${self.public_ip},' --private-key ${var.instance_ssh_priv_key} ../ansible/playbook.yml"
  }
}
