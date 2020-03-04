resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = "${aws_vpc.datasprint_vpc.id}"
}
