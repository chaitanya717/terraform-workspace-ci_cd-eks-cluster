region = "eu-west-1"
bucket_name = "dev-env-state-bucket-two-tier-app"
enviroment = "dev"
app_name = "two-tier"
vpc_cidr = "10.0.0.0/16"
vpc_name = "dev-vpc-two-tier-app"

# vpc subnet variables
 subnet_name = "public-subnet"
 subnet_cidr_block = ["10.0.1.0/24","10.0.2.0/24"]
 availability_zone = ["eu-west-1a","eu-west-1b","eu-west-1c"]
 map_public_ip_on_launch = true

#  vpc igw & rt variables
igw_name = "internet-getway"
rt_name = "route-table"
rt_cidr_route = "0.0.0.0/0"

# jenkins server variables
key_name = "jenkins"
public_key = ""
ami = ""
instance_type = "t2.medium"
instance_name = "instance"
associate_public_ip_address = true
user_data = "../terraform/Scripts/jenkin_install.sh"

# kubectl server variables
key_name_kubectl = "kubectl"
public_key_kubectl = ""
ami_kubectl = ""
instance_type_kubectl = "t2.meduim"
instance_name_kubectl = "kubectl-server"
associate_public_ip_address__kubectl = true 
user_data__kubectl = "../terraform/Scripts/kubectl_helm_install.sh"

# security group variables
sg_name = "ssh"
sg_name_softwares = "software-ports"
vpc_sg_allowports = [22,443,80]
vpc_sg_allowports_softwares = [8080,9000]