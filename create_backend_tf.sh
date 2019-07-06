#!/bin/bash
set -e
cd `dirname "$0"`
S3BUCKET="`terraform output bucket`"
S3REGION="`terraform output bucket_region`"
DDBTABLE="`terraform output lock_table`"
CRYPTOKEY="`terraform output key_arn`"

exec > ./generated_backend.tf
exec 2>&1

SCR=<<EOS
terraform {
  backend "s3" {
    bucket = "${S3BUCKET}"
    key = "state/current.tfstate"
    region = "${S3REGION}"
    encrypt = true
    acl = "private"
    kms_key_id = "${CRYPTOKEY}"
    dynamodb_table = "${DDBTABLE}"
   }
EOS
