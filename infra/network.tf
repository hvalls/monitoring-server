resource "aws_vpc" "monitoring" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "monitoring_a" {
  vpc_id     = aws_vpc.monitoring.id
  cidr_block = cidrsubnet(aws_vpc.monitoring.cidr_block, 8, 0)
}

resource "aws_internet_gateway" "monitoring" {
  vpc_id = aws_vpc.monitoring.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.monitoring.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.monitoring.id
  }
}

resource "aws_route_table_association" "monitoring-a" {
  subnet_id      = aws_subnet.monitoring_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "monitoring" {
  name        = "monitoring-server"
  vpc_id      = aws_vpc.monitoring.id

  ingress {
    description = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "Allow traffic to Prometheus server (port 9090 by default)"
    from_port        = 9090
    to_port          = 9090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "Allow traffic to Grafana (port 3000 by default)"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}