output "bucket" {
  value = aws_s3_bucket.tf_s_b.id
}

output "lock_table" {
  value = aws_dynamodb_table.tf_s_l.name
}

output "key_arn" {
  value = aws_kms_key.tf_s_k.arn
}