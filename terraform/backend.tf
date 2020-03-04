terraform {
 backend "s3" {
   bucket         = "beren-terraform"
   key            = "shared/terraform.tfstate"
   region         = "us-east-1"
   encrypt        = true
   dynamodb_table = "terraform-lock"
 }
}
