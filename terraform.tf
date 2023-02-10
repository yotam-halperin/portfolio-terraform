terraform {
  backend "s3" {
    bucket = "yotam-halperin"
    key    = "tf-conf/terraform.tfstate"
    region = "eu-west-2"
  }
}
