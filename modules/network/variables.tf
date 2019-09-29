variable "environment_id" {}
variable "environment_name" {}
variable "region" {}
variable "zones" {
  type = "list"
  default = [
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
    "us-east-1e"
  ]
}
variable "vpc_cidr" {}
