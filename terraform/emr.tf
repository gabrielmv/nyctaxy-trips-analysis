//data "template_file" "emr_configurations" {
//  template = "${file("configurations/default.json")}"
//}
//
//module "emr" {
//  source = "github.com/azavea/terraform-aws-emr-cluster?ref=0.1.0"
//
//  name          = "datasprint"
//  vpc_id        = "${aws_vpc.datasprint_vpc.id}"
//  release_label = "emr-5.29.0"
//
//  applications = [
//    "Hadoop",
//    "Ganglia",
//    "Spark",
//    "Hive",
//    "Zeppelin",
//    "Pig",
//    "Hue",
//    "JupyterHub",
//    "Livy"
//  ]
//
//  configurations = "${data.template_file.emr_configurations.rendered}"
//  key_name       = "datasprint"
//  subnet_id      = "subnet-e3sdf343"
//
//  instance_groups = [
//    {
//      name           = "MasterInstanceGroup"
//      instance_role  = "MASTER"
//      instance_type  = "m3.large"
//      instance_count = "1"
//    },
//    {
//      name           = "CoreInstanceGroup"
//      instance_role  = "CORE"
//      instance_type  = "m3.large"
//      instance_count = "1"
//    },
//  ]
//
//  bootstrap_name = "runif"
//  bootstrap_uri  = "s3://elasticmapreduce/bootstrap-actions/run-if"
//  bootstrap_args = []
//  log_uri        = "s3n://.../"
//
//}
