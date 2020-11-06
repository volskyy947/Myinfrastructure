resource "aws_instance" "Global_Instance" {
  ami = "ami-0b69ea66ff7391e80"
  availability_zone = "us-east-1b"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  vpc_security_group_ids = ["${aws_security_group.NAT_SG.id}"]
  subnet_id = "${aws_subnet.us-east-1b-private.id}"
  source_dest_check = false

  tags = {
    Name = "Global_Instance"
  }
}