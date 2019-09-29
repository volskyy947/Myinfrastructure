provider "aws" {
  region = "${var.region}"
}

module "network" {
  source      = "../../modules/network"

  environment_id = "${var.environment_id}"
  environment_name = "${var.environment_name}"
  region = "${var.region}"
  vpc_cidr = "${var.vpc_cidr}"
  zones = "${var.zones}"
}
