resource "aws_s3_bucket" "wiadro" {
  bucket = var.bucketName
}

resource "aws_s3_bucket_website_configuration" "wiadro" {
  bucket = aws_s3_bucket.wiadro.bucket

  index_document {
    suffix = var.indexWebsiteFile
  }

  error_document {
    key = var.errorWebsiteFile
  }

  routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": ""
    }
}]
EOF
}

resource "aws_s3_bucket_acl" "wiadro" {
  bucket = aws_s3_bucket.wiadro.id
  acl    = var.aclType
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.wiadro.id

  policy = <<POLICY
{
"Version": "2012-10-17",
"Statement": [
{
"Sid": "PublicReadGetObject",
"Effect": "Allow",
"Principal": "*",
"Action": "s3:GetObject",
"Resource": "arn:aws:s3:::bucket75941/*"
}
]
}
POLICY
}

resource "aws_s3_object" "wiadro" {
  bucket = aws_s3_bucket.wiadro.id
  key    = var.objectKey

}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = var.policyDocumentPrincipalsType
      identifiers = var.policyDocumentPrincipalsIdentifiers
    }

    actions = var.policyDocumentPrincipalsActions

    resources = [
      aws_s3_bucket.wiadro.arn,
      "${aws_s3_bucket.wiadro.arn}/*",
    ]
  }
}

