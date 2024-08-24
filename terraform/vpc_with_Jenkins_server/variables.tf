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

# vpc variables

variable "vpc_name" {
    type = string
}
variable "vpc_cidr" {
    type = string
}

 variable "subnet_name" {
    type = string
 }
 variable "subnet_cidr_block" {
    type = list(string)
 }
 variable "availability_zone" {
     type = list(string)
 }
 variable "map_public_ip_on_launch" {
    type = bool
 }

 variable "igw_name" {
    type = string
 }
variable "rt_name" {
    type = string
}
variable "rt_cidr_route" {
    type = string
}

# jenikins server variables
variable "key_name" {}
variable "public_key" {}
variable "ami" {}
variable "instance_type" {}
variable "instance_name" {}
variable "associate_public_ip_address" {}
variable "user_data" {}

# Kubectl server variables
variable "key_name_kubectl" {}
variable "public_key_kubectl" {}
variable "ami_kubectl" {}
variable "instance_type_kubectl" {}
variable "instance_name_kubectl" {}
variable "associate_public_ip_address__kubectl" {}
variable "user_data__kubectl" {}

# security group variables
variable "sg_name" {}
variable "sg_name_softwares" {}
variable "sg_name_eks" {}
variable "vpc_sg_allowports" {
    type = list(number)
}
variable "vpc_sg_allowports_softwares" {
    type = list(number)
}
variable "vpc_sg_allowports_eks" {
    type = list(number)
}

# eks cluster vaiables
variable "kubernetes_version" {}
variable "cluster_name" {}
 
#  node group variables

variable "eks-node-group-name" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
variable "ami_type" {}
variable "instance_types" {}
variable "disk_size" {}
