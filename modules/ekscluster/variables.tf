variable "cluster_name" {
  type        = string
  default     = "yh-cluster"
}

variable "subnet_ids" {
  type        = list(string)
}

variable "node_group_name" {
  type = string
  default = "yh-node"
}

variable "instance_type" {
  type = list(string)
  default = ["t3.2xlarge"]
}

variable "group_max_size" {
  type = number
  default = 3
}

variable "group_min_size" {
  type = number
  default = 1
}

variable "group_desired_size" {
  type = number
  default = 3
}

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
