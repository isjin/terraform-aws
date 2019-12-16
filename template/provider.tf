provider "aws" {
  profile = "default"
  region  = var.region
}

#terraform {
#  backend "s3" {
#    bucket = "terrafrom.backup"
#    key    = "terraform.tfstate"
#    region = "cn-northwest-1"
#  }
#}
