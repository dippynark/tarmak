output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_net" {
  value = "${aws_vpc.main.cidr_block}"
}

output "stack_name" {
  value = "${data.template_file.stack_name.rendered}"
}

output "private_subnet_ids" {
  value = ["${aws_subnet.private.*.id}"]
}

output "private_subnets" {
  value = ["${aws_subnet.private.*.cidr_block}"]
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "public_subnets" {
  value = ["${aws_subnet.public.*.cidr_block}"]
}

output "nat_public_ips" {
  value = ["${aws_nat_gateway.main.*.public_ip}"]
}

output "route_table_public_ids" {
  value = ["${aws_route_table.public.*.id}"]
}

output "route_table_private_ids" {
  value = ["${aws_route_table.private.*.id}"]
}

output "private_zone_id" {
  value = ["${aws_route53_zone.private.*.id}"]
}

output "private_zone" {
  value = ["${aws_route53_zone.private.*.name}"]
}

output "environment" {
  value = "${var.environment}"
}

output "availability_zones" {
  value = "${var.availability_zones}"
}
