
module "vpc" {
source = "./module/vpc"
app_name = var.app_name
env = var.enviroment
vpc_cidr = var.vpc_cidr
vpc_name = var.vpc_name
subnet_name = var.subnet_name
subnet_cidr_block = var.subnet_cidr_block
availability_zone = var.availability_zone
map_public_ip_on_launch = var.map_public_ip_on_launch 
igw_name = var.igw_name
rt_cidr_route = var.rt_cidr_route
rt_name = var.rt_name
}
module "security-groups" {
source = "./module/SecurityGroup"
sg_name = var.sg_name
sg_name_softwares = var.sg_name_softwares
vpc_id = module.vpc.vpc_id
vpc_sg_allowports = var.vpc_sg_allowports
vpc_sg_allowports_softwares = var.vpc_sg_allowports_softwares
app_name = var.app_name
env = var.enviroment 
sg_name_eks = var.sg_name_eks
vpc_sg_allowports_eks = var.vpc_sg_allowports_eks
}

module "jenkins-server" {
source = "./module/jenkins-server"
key_name = var.key_name
public_key = var.public_key
ami = var.ami
instance_type = var.instance_type
instance_name = var.instance_name
subnet_id = tolist(module.vpc.subnet_id)[0]
vpc_security_group_ids = [module.security-groups.softwares_sg]
associate_public_ip_address = var.associate_public_ip_address
user_data = var.user_data
app_name = var.app_name
env = var.enviroment
}

module "kubectl-server" {
source = "./module/kubectlserver"
key_name_kubectl = var.key_name_kubectl
public_key_kubectl = var.public_key_kubectl
ami_kubectl = var.ami_kubectl
instance_type_kubectl = var.instance_type_kubectl
instance_name_kubectl = var.instance_name_kubectl
subnet_id_kubectl = tolist(module.vpc.subnet_id)[0]
vpc_security_group_ids_kubectl = [module.security-groups.softwares_sg]
associate_public_ip_address_kubectl = var.associate_public_ip_address__kubectl
user_data_kubectl = var.user_data__kubectl
app_name = var.app_name
env = var.enviroment
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
source = "./module/eks-cluster"
cluster_name = var.cluster_name
EKSClusterRole_arn = module.iam-role-eks.EKSClusterRole_arn
aws_iam_role_policy_attachment_AmazonEKSClusterPolicy_id = module.iam-policy-eks.AmazonEKSClusterPolicy_id
security_group_ids = [module.security-groups.ssh_sg,module.security-groups.eks-sg]
subnet_ids = tolist(module.vpc.subnet_id)
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
