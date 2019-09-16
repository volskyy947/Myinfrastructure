provider "aws" {
  region = "${var.region}"
}

// create VPC
resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  tags {
    Name = "${var.environment_name} VPC"
    Environment = "${var.environment_id}"
  }
}

// internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.environment_name} Internet Gateway"
    Environment = "${var.environment_id}"
  }
  }
