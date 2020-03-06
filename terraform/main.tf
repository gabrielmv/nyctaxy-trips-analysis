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
    aws_s3_bucket.datasprint_bucket
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2009" {
  bucket     = aws_s3_bucket.datasprint_bucket.bucket
  key        = "nyctaxi-trips-2009.json"
  source     = "../data/data-sample_data-nyctaxi-trips-2009-json_corrigido.json"

  depends_on = [
    aws_s3_bucket.datasprint_bucket
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2010" {
  bucket     = aws_s3_bucket.datasprint_bucket.bucket
  key        = "nyctaxi-trips-2010.json"
  source     = "../data/data-sample_data-nyctaxi-trips-2010-json_corrigido.json"

  depends_on = [
    aws_s3_bucket.datasprint_bucket
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2011" {
  bucket     = aws_s3_bucket.datasprint_bucket.bucket
  key        = "nyctaxi-trips-2011.json"
  source     = "../data/data-sample_data-nyctaxi-trips-2011-json_corrigido.json"

  depends_on = [
    aws_s3_bucket.datasprint_bucket
  ]
}

resource "aws_s3_bucket_object" "nyctaxi-trips-2012" {
  bucket     = aws_s3_bucket.datasprint_bucket.bucket
  key        = "nyctaxi-trips-2012.json"
  source     = "../data/data-sample_data-nyctaxi-trips-2012-json_corrigido.json"

  depends_on = [
    aws_s3_bucket.datasprint_bucket
  ]
}

resource "aws_instance" "producer" {
  ami             = "ami-046842448f9e74e7d"
  instance_type   = "t2.micro"
  key_name        = "datasprint"
  security_groups = ["${aws_security_group.ingress-all-test.id}"]
  subnet_id       = "${aws_subnet.subnet-uno.id}"

  user_data       = <<-EOF
    #!/bin/bash
    apt upgrade -y
    apt install python3-pip -y
    apt install python3 --upgrade -y
    pip3 install awscli --upgrade
    pip3 install boto3"
  EOF


  tags           = {
    Name         = "datasprint"
  }
}

resource "aws_kinesis_stream" "datasprint_stream" {
  name          = "ny-taxi-trips"
  shard_count   = 1

  tags          = {
    Name        = "datasprint-test"
    Environment = "dev"
  }
}

resource "aws_emr_cluster" "cluster" {
  name           = "datasprint_emr"
  release_label  = "emr-5.29.0"
  applications   = [
    "Hadoop",
    "Ganglia",
    "Spark",
    "Hive",
//    "Zeppelin",
//    "Pig",
//    "Hue",
//    "JupyterHub",
    "Livy"
  ]

  termination_protection            = false
  keep_job_flow_alive_when_no_steps = true

  ec2_attributes {
    key_name                          = "datasprint"
    subnet_id                         = "${aws_subnet.subnet-uno.id}"
    emr_managed_master_security_group = "${aws_security_group.emr_master.id}"
    emr_managed_slave_security_group  = "${aws_security_group.emr_slave.id}"
    instance_profile                  = "${aws_iam_instance_profile.emr_ec2_instance_profile.arn}"
  }

  master_instance_group {
    instance_type = "m4.large"

    ebs_config {
      size                 = "20"
      type                 = "gp2"
      volumes_per_instance = 1
    }
  }

  core_instance_group {
    instance_type = "m4.large"
    instance_count = 1

    ebs_config {
      size                 = "20"
      type                 = "gp2"
      volumes_per_instance = 1
    }
  }

  bootstrap_action {
    path = "s3://elasticmapreduce/bootstrap-actions/run-if"
    name = "runif"
    args = ["instance.isMaster=true", "echo running on master node"]
  }

  log_uri      = "s3://aws-logs-635255901326-us-east-1/elasticmapreduce/"
  service_role = "${aws_iam_role.emr_service_role.arn}"
}
