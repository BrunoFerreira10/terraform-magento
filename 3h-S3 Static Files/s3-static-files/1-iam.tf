resource "aws_iam_role" "magento-s3-role" {
  name = "magento-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "magento-s3-policy" {
  name = "magento-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.magento-static-files.arn}",
          "${aws_s3_bucket.magento-static-files.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "magento-s3-attachment" {
  role       = aws_iam_role.magento-s3-role.name
  policy_arn = aws_iam_policy.magento-s3-policy.arn
}