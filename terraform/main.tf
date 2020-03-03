provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_kinesis_stream" "datasprint_stream" {
  name             = "ny-taxi-trips"
  shard_count      = 1

  tags = {
    Name        = "datasprint-test"
    Environment = "dev"
  }
}
