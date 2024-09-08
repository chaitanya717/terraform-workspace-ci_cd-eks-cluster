# security group variables
env = ""
app_name = ""

sg_name_eks = "sg-eks-twotier-app-ports"
vpc_sg_allowports_eks = [22,443,80]

vpc_id = ""
subnet_ids = ["",""]

# eks cluster vaiables
kubernetes_version = 1.28
cluster_name = "eks-cluster"
eks-node-group-name = "dev-node-group-two-tier-app"
desired_size = 2
max_size = 3
min_size = 1
ami_type = "AL2_x86_64"
instance_types_eks = ["t2.medium"]
disk_size = 20



