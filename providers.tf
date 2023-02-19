
provider "aws" {
  region = module.network.region
  default_tags {
    tags = {
      owner = "yotam_halperin"
      bootcamp       = "17"
      expiration_date     = "23-02-23"
    }
  }
}


provider "kubernetes" {
  host                   = module.ekscluster.endpoint
  cluster_ca_certificate = base64decode(module.ekscluster.kubeconfig-certificate-authority-data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", lookup(var.cluster_name, terraform.workspace)]
    command     = "aws"
  }
}


provider "helm" {
  kubernetes {
    host                   = module.ekscluster.endpoint
    cluster_ca_certificate = base64decode(module.ekscluster.kubeconfig-certificate-authority-data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", lookup(var.cluster_name, terraform.workspace)]
      command     = "aws"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.39"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "yotam-portfolio"
    key    = "tf-conf/terraform.tfstate"
    region = "eu-west-2"
  }
}
