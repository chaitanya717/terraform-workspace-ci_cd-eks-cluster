# security group variables
enviroment = "dev"
app_name = "two-tier"

region = "eu-west-1"
bucket_name = "dev-env-eks-state-bucket-two-tier-app"

sg_name_eks = "sg-eks-twotier-app-ports"
vpc_sg_allowports_eks = [22,443,80]

vpc_id = "vpc-048137d78fab35ef5"
subnet_ids = ["subnet-01d9baa40a65355d3","subnet-009bc95457d949a3e"]

# eks cluster vaiables
kubernetes_version = 1.28
cluster_name = "eks-cluster"
eks-node-group-name = "dev-node-group-two-tier-app"
desired_size = 1
max_size = 3
min_size = 1
ami_type = "AL2_x86_64"
instance_types_eks = ["t2.medium"]
disk_size = 20



