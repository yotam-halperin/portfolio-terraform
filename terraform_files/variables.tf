variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable cluster_name {
  type        = string
  default     = "yh-cluster"
  description = "Name of the Kubernetes cluster"
}

variable vpc_name {
  type        = string
  default     = "yh-vpc"
  description = "create a new VPC for the cluster"
}


