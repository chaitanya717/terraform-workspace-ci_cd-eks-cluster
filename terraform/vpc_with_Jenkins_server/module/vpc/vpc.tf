variable "vpc_name" {}
variable "vpc_cidr" {}
variable "env" {}
variable "app_name" {}

# variables subnet
 variable "subnet_name" {}
 variable "subnet_cidr_block" {}
 variable "availability_zone" {}
 variable "map_public_ip_on_launch" {}

#  internetgeway and Routetable variable
variable "igw_name" {}
variable "rt_name" {}
variable "rt_cidr_route" {}

output "vpc_id" {
  value = aws_vpc.vpc.id 
}

output "subnet_id" {
  value = aws_subnet.subnet.*.id
}
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "${var.env}-${var.app_name}-${var.vpc_name}"
    } 
}

resource "aws_subnet" "subnet" {
  count = length(var.subnet_cidr_block)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.subnet_cidr_block, count.index)
  availability_zone = element(var.availability_zone, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "${count.index + 1}-${var.env}-${var.subnet_name}-subnet-${var.app_name}"
  }
}

resource "aws_internet_gateway" "aws-internet-gateway" {
vpc_id = aws_vpc.vpc.id

tags = {
  Name = "${var.env}${var.igw_name}-${var.app_name}"
}
}

resource "aws_route_table" "aws-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.rt_cidr_route
    gateway_id = aws_internet_gateway.aws-internet-gateway.id
  }

  tags = {
    Name = "${var.env}-${var.rt_name}-${var.app_name}"
  }
}

resource "aws_route_table_association" "route-table-association" {
  count = length(var.subnet_cidr_block)
  subnet_id = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.aws-route-table.id
}