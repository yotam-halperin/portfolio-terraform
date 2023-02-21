### network variables

variable "region" {
  type        = map
  default     = {
    "default" = "eu-west-2",
    "PROD" = "eu-west-2"
  }
  description = "AWS region"
}

variable "vpc_name" {
  type        = map
  default = {
    "default" = "yh-vpc",
    "PROD" = "yh-vpc-production"
  }
}

variable "vpc_cidr" {
  type        = map
  default     = {
    "default" = "10.10.0.0/16",
    "PROD" = "10.20.0.0/16"
  }
}


variable "num_of_subnets" {
  type        = number
  default     = 2
}

variable "subnet_cidr" {
  type        = map
  default     = {
    "default" = ["10.10.10.0/24", "10.10.20.0/24", "10.10.30.0/24"],
    "PROD" = ["10.20.10.0/24", "10.20.20.0/24", "10.20.30.0/24"]
  }
}

variable "subnet_azs" {
  type        = map
  default     = {
    "default" = ["eu-west-2a", "eu-west-2b", "eu-west-2c"],
    "PROD" = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  }
}

### ekscluster variables

variable "cluster_name" {
  type        = map
  default     = {
    "default" = "yh-cluster"
    "PROD" = "yh-production"
  }
}

# node vars
variable "node_group_name" {
  type = map
  default     = {
    "default" = "yh-node",
    "PROD" = "yh-node-prod"
  }
}

variable "instance_type" {
  type = list(string)
  default = ["t3.2xlarge"]
}

variable "group_max_size" {
  type = map
  default = {
    "default" = 4
    "PROD" = 4
  }
}

variable "group_min_size" {
  type = map
  default = {
    "default" = 1
    "PROD" = 1
  }
}

variable "group_desired_size" {
  type = map
  default = {
    "default" = 3
    "PROD" = 3
  }
}

# helm argocd vars

variable "argocd_repo" {
  type = string
  default = "https://argoproj.github.io/argo-helm"
}

variable "argocd_chart" {
  type = string
  default = "argo-cd"
}

variable "argocd_namespace" {
  type = string
  default = "argocd"
}

variable "argocd_create_namespace" {
  type = bool
  default = true
}

variable "argocd_version" {
  type = string
  default = "4.9.7"
}

variable "argocd_application_path" {
  type = string
  default = "modules/ekscluster/argocd/application.yaml"
}

variable "ssh_parameter_name" {
  type = string
  default = "private_key_yh"
}

variable "argocd_repo_type" {
  type = string
  default = "git"
}

variable "argocd_repo_url" {
  type = string
  default = "git@github.com:yotam-halperin/portfolio-charts.git"
}

variable "argocd_repo_place" {
  type = string
  default = "github"
}
