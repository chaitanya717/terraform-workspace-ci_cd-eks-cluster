variable "cluster_name" {}
variable "EKSClusterRole_arn" {}
variable "aws_iam_role_policy_attachment_AmazonEKSClusterPolicy_id" {}
variable "security_group_ids" {
    type = list(string)
}
variable "subnet_ids" {}
variable "app_name" {}
variable "env" {}

variable "kubernetes_version" {}

resource "aws_eks_cluster" "eks-cluster" {
  name = "${var.env}-${var.cluster_name}-${var.app_name}"
  role_arn = var.EKSClusterRole_arn

  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  version = var.kubernetes_version

  depends_on = [ var.aws_iam_role_policy_attachment_AmazonEKSClusterPolicy_id ]
}
