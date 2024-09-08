terraform {
  backend "s3" {
    bucket = "dev-env-eks-state-bucket-two-tier-app"
    key = "./terraform.tfstate"
    region = "eu-west-1"
  }
}