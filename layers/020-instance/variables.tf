variable "region" {
  default = "us-east-1"
  description = "AWS Region"
}
variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default = "10.0.3.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = "10.0.4.0/24"
}

variable "aws_key_name" {
  default = "essentialskp"
}