variable "region" {
  type        = string
  default = "eu-west-2"
}

variable "vpc_name" {
  type        = string
  default = "yh-vpc"
}


variable "vpc_cidr" {
  type        = string
  default = "10.10.0.0/16"
}

variable "num_of_subnets" {
  type        = number
  default = 2
}

variable "subnet_cidr" {
  type = list(string)
  default = ["10.10.10.0/24", "10.10.20.0/24", "10.10.30.0/24"]
}

variable "subnet_azs" {
  type = list(string)
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

### delete defaults !!!