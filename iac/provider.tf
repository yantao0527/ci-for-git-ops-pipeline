provider "aws" {
  region = var.region
  profile = var.profile
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "usyt-lfm-gitops-pipeline-terraform-state"
    key = "usyt-lfm-gitops/terraform.tfstate"
    region = "us-east-2"
#    encrypt = true
  }
}