variable "network" {}

variable "name" {}

variable "project" {}

variable "contact" {}

variable "region" {}

variable "availability_zones" {
  type = "list"
}

variable "vpc_id" {}

variable "public_subnets" {}

variable "private_subnets" {}

variable "stack" {
  default = ""
}

variable "state_bucket" {
  default = ""
}

variable "stack_name_prefix" {
  default = ""
}

data "template_file" "stack_name" {
  template = "${var.stack_name_prefix}${var.environment}-${var.name}"
}

variable "allowed_account_ids" {
  type    = "list"
  default = []
}

variable "vpc_peer_stack" {
  default = ""
}

variable "environment" {
  default = "nonprod"
}

variable "private_zone" {
  default = ""
}

variable "state_cluster_name" {
  default = "hub"
}

# data.terraform_remote_state.vpc_peer_stack.private_zone_id
variable "private_zone_id" {}