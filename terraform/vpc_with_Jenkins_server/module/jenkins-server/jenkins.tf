variable "key_name" {}
variable "public_key" {}
variable "ami" {}
variable "instance_type" {}
variable "instance_name" {}
variable "subnet_id" {}
variable "vpc_security_group_ids" {
   type = list(string)
}
variable "associate_public_ip_address" {}
variable "user_data" {}
variable "env" {}
variable "app_name" {}

resource "aws_key_pair" "key-pair" {
  key_name = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "aws-instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address

  user_data = file("./jenkin_install.sh")

  tags = {
    Name = "${var.env}-${var.instance_name}-${var.app_name}"
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}