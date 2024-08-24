
variable "eks-node-group-name" {}
variable "NodeGroupRole_arn" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}

variable "ami_type" {}
variable "instance_types" {
    type = list(string)
}
variable "disk_size" {}
variable "AmazonEC2ContainerRegistryReadOnly_policy_id" {}
variable "AmazonEKS_CNI_Policy_id" {}
variable "AmazonEKSWorkerNodePolicy_Policy_id" {}

resource "aws_eks_node_group" "eks-node-group" {
  
  cluster_name = aws_eks_cluster.eks-cluster.name
  node_group_name = var.eks-node-group-name
  node_role_arn = var.NodeGroupRole_arn
  subnet_ids = var.subnet_ids

  scaling_config {
    desired_size = var.desired_size
    max_size = var.min_size
    min_size = var.min_size
  }

  ami_type = var.ami_type
  instance_types = var.instance_types
  disk_size = var.disk_size

  depends_on = [ var.AmazonEC2ContainerRegistryReadOnly_policy_id,
  var.AmazonEKS_CNI_Policy_id,
  var.AmazonEKSWorkerNodePolicy_Policy_id]
}