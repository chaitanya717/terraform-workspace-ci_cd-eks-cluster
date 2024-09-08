
variable "sg_name_eks" {}

variable "vpc_id" {}

variable "vpc_sg_allowports_eks" {}

variable "env" {}
variable "app_name" {}



output "eks-sg" {
  value = aws_security_group.security-group-eks.id
}
resource "aws_security_group" "security-group-eks" {
  name = "${var.env}-${var.sg_name_eks}-${var.app_name}"
  vpc_id = var.vpc_id

  ingress = [
    for port in var.vpc_sg_allowports_eks : {
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
    Name = "${var.env}-${var.sg_name_eks}-${var.app_name}"
  }
}