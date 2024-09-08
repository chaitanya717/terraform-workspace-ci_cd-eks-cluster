variable "region" {
  type = string
}
variable "bucket_name" {
  type = string
}

variable "enviroment" {
    type = string
}
variable "app_name" {
    type = string
}


variable "sg_name_eks" {}

variable "vpc_id" {}
variable "subnet_ids" {}

variable "vpc_sg_allowports_eks" {}

variable "env" {}
variable "app_name" {}



variable "kubernetes_version" {}
variable "cluster_name" {}
 
#  node group variables

variable "eks-node-group-name" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
variable "ami_type" {}
variable "instance_types_eks" {}
variable "disk_size" {}