

variable "EKSClusterRole_name" {}
variable "NodeGroupRole_name" {}




output "AmazonEKSClusterPolicy_id" {
  value = aws_iam_role_policy_attachment.AmazonEKSClusterPolicy.id
}
output "AmazonEKSWorkerNodePolicy_id" {
  value = aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy.id
}
output "AmazonEC2ContainerRegistryReadOnly_id" {
  value = aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly.id
}
output "AmazonEKS_CNI_Policy_id" {
  value = aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy.id
}




resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = var.EKSClusterRole_name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = var.NodeGroupRole_name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = var.NodeGroupRole_name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = var.NodeGroupRole_name
}