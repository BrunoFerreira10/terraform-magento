output "magento-static-files-arn" {
  value = aws_s3_bucket.magento-static-files.arn
}

output "magento-static-files-bucket" {
  value = aws_s3_bucket.magento-static-files.bucket
}

output "magento-s3-role-name" {
  value = aws_iam_role.magento-s3-role.name
}

