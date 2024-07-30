resource "aws_s3_bucket" "magento-static-files" {
  bucket = "${var.static-files-bucket-name}"

  tags = {
    Name = "${var.static-files-bucket-name}"
  }
}

# resource "aws_s3_bucket_versioning" "versionamento-s3-remote-state" {
#   bucket = aws_s3_bucket.magento-static-files.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_acl" "magento-static-files-acl" {
#   bucket = aws_s3_bucket.magento-static-files.id
#   acl    = "private"
# }

resource "aws_s3_bucket_public_access_block" "magento-static-files-access-block" {
  bucket = aws_s3_bucket.magento-static-files.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}