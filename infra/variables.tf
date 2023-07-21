variable "aws_profile" {
  type    = string
  default = ""
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-06935448000742e6b" // Amazon Linux 2023
}

variable "instance_ssh_key" {
  type = string
}
