terraform {
  backend "s3" {
    bucket = "yotam-portfolio"
    key    = "tf-conf/terraform.tfstate"
    region = "eu-west-2"
  }
}
