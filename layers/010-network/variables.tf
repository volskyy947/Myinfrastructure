variable "environment_id" {
  default = "dev-credo-1"
  description = "ID of the stack"
}
variable "environment_name" {
  default = "Dev Credo 1"
  description = "Friendly name of the stack"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "VPC CIDR"
}
variable "region" {
  default = "us-east-1"
  description = "AWS Region"
}
variable "zones" {
  type = "list"
  default = [
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
    "us-east-1e"
  ]
  description = "List of availability zones"
}