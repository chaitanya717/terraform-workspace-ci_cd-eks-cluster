variable "sg_name" {}
variable "sg_name_softwares" {}
variable "vpc_id" {}
variable "vpc_sg_allowports" {}
variable "vpc_sg_allowports_softwares" {}
variable "env" {}
variable "app_name" {}
output "ssh_sg" {
  value = aws_security_group.security-group.id
}

output "softwares_sg" {
  value = aws_security_group.security-group-softwares.id
}

resource "aws_security_group" "security-group" {
  name = "${var.env}-${var.sg_name}-${var.app_name}"
  vpc_id = var.vpc_id

  ingress = [
    for port in var.vpc_sg_allowports : {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = port
    to_port = port
    protocol = "tcp"
    description = "port allow"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = null
    }
  ]

  egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.sg_name}-${var.app_name}"
  }
}
resource "aws_security_group" "security-group-softwares" {
  name = "${var.env}-${var.sg_name_softwares}-${var.app_name}"
  vpc_id = var.vpc_id

  ingress = [
    for port in var.vpc_sg_allowports_softwares : {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = port
    to_port = port
    protocol = "tcp"
    description = "port allow"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = [aws.aws_security_group.security-group]
    self             = null
    }
  ]

  egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.sg_name_softwares}-${var.app_name}"
  }
}