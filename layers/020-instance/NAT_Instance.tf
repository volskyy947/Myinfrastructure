provider "aws" {
  region = "${var.region}"
}
resource "aws_vpc" "Project_VPC" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "Project_VPC"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.Project_VPC.id}"
}

/*
  NAT Instance
*/
resource "aws_security_group" "NAT_SG" {
  name = "vpc_nat"
  description = "Allow traffic to pass from the private subnet to the internet"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.private_subnet_cidr}"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${var.private_subnet_cidr}"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  egress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.Project_VPC.id}"

  tags = {
    Name = "NAT_SG"
  }
}

resource "aws_instance" "NAT_Instance" {
  ami = "ami-00a9d4a05375b2763"
  availability_zone = "us-east-1b"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  vpc_security_group_ids = ["${aws_security_group.NAT_SG.id}"]
  subnet_id = "${aws_subnet.us-east-1b-public.id}"
  associate_public_ip_address = true
  source_dest_check = false

  tags = {
    Name = "NAT_Instance"
  }
}

resource "aws_eip" "nat" {
  instance = "${aws_instance.NAT_Instance.id}"
  vpc = true
}

/*
  Public Subnet
*/
resource "aws_subnet" "us-east-1b-public" {
  vpc_id = "${aws_vpc.Project_VPC.id}"

  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_route_table" "us-east-1b-public" {
  vpc_id = "${aws_vpc.Project_VPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_route_table_association" "us-east-1b-public" {
  subnet_id = "${aws_subnet.us-east-1b-public.id}"
  route_table_id = "${aws_route_table.us-east-1b-public.id}"
}

/*
  Private Subnet
*/
resource "aws_subnet" "us-east-1b-private" {
  vpc_id = "${aws_vpc.Project_VPC.id}"

  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_route_table" "us-east-1b-private" {
  vpc_id = "${aws_vpc.Project_VPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.NAT_Instance.id}"
  }

  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_route_table_association" "us-east-1b-private" {
  subnet_id = "${aws_subnet.us-east-1b-private.id}"
  route_table_id = "${aws_route_table.us-east-1b-private.id}"
}