provider "aws" {
  region = var.region
  version = "~> 2.0"
}

# data "aws_caller_identity" "current" {}

# data "aws_region" "current" {}

resource "aws_s3_bucket" "tf_s_b" {
  bucket_prefix = "tf-s-${terraform.workspace}-"
  acl = "private"
  region = var.region
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Environment = "${terraform.workspace}"
    Project = "Tinkering"
  }
}

resource "aws_dynamodb_table" "tf_s_l" {
  name = "tf-s-${terraform.workspace}-locking"
  read_capacity = 1
  write_capacity = 1
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type ="S"
  }

  tags = {
    Environment = "${terraform.workspace}"
    Project = "Tinkering"
  }
}

resource "aws_kms_key" "tf_s_k" {
  description = "terraform state crypto key for ${terraform.workspace}"
  tags = {
    Environment = "${terraform.workspace}"
    Project = "Tinkering"
  }
}