output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
output "vpc_cidr" {
  value = "${var.vpc_cidr}"
}
output "public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}
output "private_subnet_ids" {
  value = ["${aws_subnet.private.*.id}"]
}
output "public_security_group_ids" {
  value = ["${aws_security_group.public.*.id}"]
}
output "public_subnet_route_ids" {
  value = ["${aws_route_table.public.*.id}"]
}
output "private_subnet_route_ids" {
  value = ["${aws_route_table.private.*.id}"]
}
output "region" {
  value = "${var.region}"
}
output "environment_id" {
  value = "${var.environment_id}"
}
output "environment_name" {
  value = "${var.environment_name}"
}
output "zones" {
  value = "${var.zones}"
}
