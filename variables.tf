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

### helm variables

variable "instance_ami" {
  type        = map
  default     = {
    "default" = "ami-01b8d743224353ffe",
    "PROD" = "ami-01b8d743224353ffe"
  }
}

variable "instance_type" {
  type        = map
  default     = {
    "default" = "t3a.small",
    "PROD" = "t3a.small"
  }
}


### ekscluster variables

variable "cluster_name" {
  type        = map
  default     = {
    "default" = "yh-cluster"
    "PROD" = "yh-production"
  }
  description = "Name of the Kubernetes cluster"
}
