// public
resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.main.id}"
  count = "${length(var.zones)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 12, count.index * 2)}"
  availability_zone = "${element(var.zones, count.index)}"

  tags {
    Name = "${var.environment_name} Public Subnet"
    Environment = "${var.environment_id}"
  }
}

// private
resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.main.id}"
  count = "${length(var.zones)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 12, (count.index * 2 + 1))}"
  availability_zone = "${element(var.zones, count.index)}"

  tags {
    Name = "${var.environment_name} Private Subnet"
    Environment = "${var.environment_id}"
  }
}
