provider "aws" {
  region              = "${var.region}"
  allowed_account_ids = ["${var.allowed_account_ids}"]
  version             = "~> 1.7.1"
}

provider "template" {
  version = "~> 1.0"
}

#data "aws_acm_certificate" "wildcard" {
#  domain   = "*.${data.terraform_remote_state.state.public_zone}"
#  statuses = ["ISSUED"]
#}

data "aws_elb_hosted_zone_id" "main" {}
