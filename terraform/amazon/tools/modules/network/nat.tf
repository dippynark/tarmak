resource "aws_eip" "nat" {
  count = "${length(var.availability_zones)}"
  vpc   = true
}

resource "aws_nat_gateway" "main" {
  depends_on    = ["aws_internet_gateway.main"]
  count         = "${length(var.availability_zones)}"
  allocation_id = "${aws_eip.nat.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public.*.id[count.index]}"
}
