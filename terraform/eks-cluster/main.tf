module "security-groups" {
source = "./module/SecurityGroup"
app_name = var.app_name
env = var.enviroment 
sg_name_eks = var.sg_name_eks
vpc_sg_allowports_eks = var.vpc_sg_allowports_eks
vpc_id = var.vpc_id
}

module "iam-policy-eks" {
  source = "./module/iam-policy-eks"
  EKSClusterRole_name = module.iam-role-eks.EKSClusterRole_name
  NodeGroupRole_name = module.iam-role-eks.NodeGroupRole_name
}

module "iam-role-eks" {
    source = "./module/iam-role-eks"
}

module "eks-cluster" {
source = "./module/cluster"
cluster_name = var.cluster_name
EKSClusterRole_arn = module.iam-role-eks.EKSClusterRole_arn
aws_iam_role_policy_attachment_AmazonEKSClusterPolicy_id = module.iam-policy-eks.AmazonEKSClusterPolicy_id
security_group_ids = [module.security-groups.eks-sg]
subnet_ids = var.subnet_ids
app_name = var.app_name
env = var.enviroment
kubernetes_version = var.kubernetes_version

# node group variables
eks-node-group-name = var.eks-node-group-name
NodeGroupRole_arn = module.iam-role-eks.NodeGroupRole_arn
desired_size = var.desired_size
max_size = var.max_size
min_size = var.min_size
ami_type = var.ami_type
instance_types = var.instance_types_eks
disk_size = var.disk_size
AmazonEC2ContainerRegistryReadOnly_policy_id = module.iam-policy-eks.AmazonEC2ContainerRegistryReadOnly_id
AmazonEKS_CNI_Policy_id = module.iam-policy-eks.AmazonEKS_CNI_Policy_id
AmazonEKSWorkerNodePolicy_Policy_id = module.iam-policy-eks.AmazonEKSWorkerNodePolicy_id
}


