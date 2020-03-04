resource "aws_vpc" "datasprint_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_eip" "producer_ip" {
  instance = "${aws_instance.producer.id}"
  vpc      = true
}
