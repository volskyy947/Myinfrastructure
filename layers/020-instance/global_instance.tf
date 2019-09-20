resource "aws_instance" "global_instance" {
  count = "${var.global_instance}"
  instance_type = "${var.global_instance_size}"
  availability_zone = "${element(data.terraform_remote_state.network.zones, count.index)}"
  ami = "${var.base_image}"
  subnet_id = "${element(data.terraform_remote_state.network.private_subnet_ids, count.index)}"
  vpc_security_group_ids = ["${aws_security_group}"]
  key_name = "${ var.ssh_key=="" ? data.terraform_remote_state.network.nat_key : var.ssh_key}"
  depends_on = ["aws_security_group"]
  ebs_optimized = "${var.global_instance_ebs_optimized}"