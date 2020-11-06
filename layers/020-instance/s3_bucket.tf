resource "aws_s3_bucket" "projectbucket2019" {
  bucket = "${var.s3_bucket_name}"
  acl = "public-read"
  policy = <<POLICY
{"Version":  "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.s3_bucket_name}/*"
    },
    {
      "Sid": "PublicReadObject",
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.s3_bucket_name}/*",
      "Condition": {
        "Bool":
        { "aws:SecureTransport": false}
      }
    }
  ]
}
POLICY
}
