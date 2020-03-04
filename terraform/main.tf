resource "aws_s3_bucket" "datasprint_bucket" {
  bucket = "datasprint-test"
  acl    = "private"

  tags   = {
    Name        = "datasprint-test"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_object" "vendor_lookup" {
  bucket     = aws_s3_bucket.datasprint_bucket.bucket
  key        = "vendor_lookup.csv"
  source     = "../data/data-vendor_lookup-csv.csv"

  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

resource "aws_s3_bucket_object" "payment_lookup" {
  bucket     = aws_s3_bucket.datasprint_bucket.bucket
  key        = "payment_lookup.csv"
  source     = "../data/data-payment_lookup-csv.csv"

  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2009" {
  bucket     = aws_s3_bucket.datasprint_bucket.bucket
  key        = "nyctaxi-trips-2009.json"
  source     = "../data/data-sample_data-nyctaxi-trips-2009-json_corrigido.json"

  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2010" {
  bucket     = aws_s3_bucket.datasprint_bucket.bucket
  key        = "nyctaxi-trips-2010.json"
  source     = "../data/data-sample_data-nyctaxi-trips-2010-json_corrigido.json"

  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2011" {
  bucket     = aws_s3_bucket.datasprint_bucket.bucket
  key        = "nyctaxi-trips-2011.json"
  source     = "../data/data-sample_data-nyctaxi-trips-2011-json_corrigido.json"

  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2012" {
  bucket     = aws_s3_bucket.datasprint_bucket.bucket
  key        = "nyctaxi-trips-2012.json"
  source     = "../data/data-sample_data-nyctaxi-trips-2012-json_corrigido.json"

  depends_on = [
    aws_s3_bucket.datasprint_bucket,
  ]
}

resource "aws_instance" "producer" {
  ami = "ami-046842448f9e74e7d"
  instance_type = "t2.micro"
  key_name = "datasprint"
  security_groups = ["${aws_security_group.ingress-all-test.id}"]
  subnet_id = "${aws_subnet.subnet-uno.id}"
  tags   = {
    Name = "datasprint"
  }
}

resource "aws_kinesis_stream" "datasprint_stream" {
  name             = "ny-taxi-trips"
  shard_count      = 1

  tags = {
    Name        = "datasprint-test"
    Environment = "dev"
  }
}
