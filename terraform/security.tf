resource "aws_security_group" "ingress-all-test" {
  name = "allow-all-sg"
  vpc_id = "${aws_vpc.datasprint_vpc.id}"
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_security_group" "emr_master" {
  vpc_id = "${aws_vpc.datasprint_vpc.id}"
  revoke_rules_on_delete = true
  ingress {
    from_port        = 22
    protocol         = "tcp"
    to_port          = 22
    cidr_blocks      = [
      "0.0.0.0/0"
    ]
    ipv6_cidr_blocks = [
      "::/0"
    ]
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_security_group" "emr_slave" {
  vpc_id =  "${aws_vpc.datasprint_vpc.id}"
  revoke_rules_on_delete = true
}
