provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "datasprint_bucket" {
  bucket = "datasprint-test"
  acl    = "private"

  tags   = {
    Name        = "datasprint-test"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_object" "vendor_lookup" {
  bucket = aws_s3_bucket.datasprint_bucket.bucket
  key    = "vendor_lookup.csv"
  source = "../data/data-vendor_lookup-csv.csv"

  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

resource "aws_s3_bucket_object" "payment_lookup" {
  bucket = aws_s3_bucket.datasprint_bucket.bucket
  key    = "payment_lookup.csv"
  source = "../data/data-payment_lookup-csv.csv"

  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2009" {
  bucket = aws_s3_bucket.datasprint_bucket.bucket
  key    = "nyctaxi-trips-2009.json"
  source = "../data/data-sample_data-nyctaxi-trips-2009-json_corrigido.json"
  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2010" {
  bucket = aws_s3_bucket.datasprint_bucket.bucket
  key    = "nyctaxi-trips-2010.json"
  source = "../data/data-sample_data-nyctaxi-trips-2010-json_corrigido.json"
  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2011" {
  bucket = aws_s3_bucket.datasprint_bucket.bucket
  key    = "nyctaxi-trips-2011.json"
  source = "../data/data-sample_data-nyctaxi-trips-2011-json_corrigido.json"
  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2012" {
  bucket = aws_s3_bucket.datasprint_bucket.bucket
  key    = "nyctaxi-trips-2012.json"
  source = "../data/data-sample_data-nyctaxi-trips-2012-json_corrigido.json"
  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

//data "aws_ami" "ubuntu" {
//  most_recent = true
//
//  filter {
//    name   = "name"
//    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
//  }
//
//  filter {
//    name   = "virtualization-type"
//    values = ["hvm"]
//  }
//
//  owners = ["099720109477"] # Canonical
//}
//
//resource "aws_instance" "producer" {
//  ami           = "${data.aws_ami.ubuntu.id}"
//  instance_type = "t2.micro"
//
//  tags = {
//    Name = "datasprint-test"
//  }
//}
//
//resource "aws_kinesis_stream" "datasprint_stream" {
//  name             = "ny-taxi-trips"
//  shard_count      = 1
//  retention_period = 24
//
//  tags = {
//    Name        = "datasprint-test"
//    Environment = "dev"
//  }
//}

