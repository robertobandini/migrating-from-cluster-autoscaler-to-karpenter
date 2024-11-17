terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.59.0"
    }
    awsutils = {
      source  = "cloudposse/awsutils"
      version = "0.19.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.14.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.31.0"
    }
  }
}