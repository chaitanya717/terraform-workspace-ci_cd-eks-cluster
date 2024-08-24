variable "key_name_kubectl" {}
variable "public_key_kubectl" {}
variable "ami_kubectl" {}
variable "instance_type_kubectl" {}
variable "instance_name_kubectl" {}
variable "subnet_id_kubectl" {}
variable "vpc_security_group_ids_kubectl" {
  type = list(string)
}
variable "associate_public_ip_address_kubectl" {}
variable "user_data_kubectl" {}
variable "env" {}
variable "app_name" {}

resource "aws_key_pair" "key-pair" {
  key_name = var.key_name_kubectl
  public_key = var.public_key_kubectl
}

resource "aws_instance" "aws-instance" {
  ami = var.ami_kubectl
  instance_type = var.instance_type_kubectl

  tags = {
    Name = "${var.env}-${var.instance_name_kubectl}-${var.app_name}"
  }

  key_name = var.key_name_kubectl
  subnet_id = var.subnet_id_kubectl
  vpc_security_group_ids = var.vpc_security_group_ids_kubectl
  associate_public_ip_address = var.associate_public_ip_address_kubectl
  user_data = var.user_data_kubectl

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}