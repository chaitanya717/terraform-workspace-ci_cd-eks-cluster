
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

