
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
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    host                   = module.ekscluster.endpoint
    cluster_ca_certificate = base64decode(module.ekscluster.kubeconfig-certificate-authority-data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}
