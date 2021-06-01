resource "aws_s3_bucket" "poc_s3_bucket" {
  bucket = var.bucket_name
  acl    = "private"
  tags = var.DEFAULT_TAGS
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm  = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "poc-bucket-public-access-block" {
  bucket = aws_s3_bucket.poc_s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.poc_s3_bucket.id
  for_each = fileset(var.object_dir, "*")
  key    = each.value
  content_type = "text/html"
  source = "${var.object_dir}/${each.value}"
  server_side_encryption = "AES256"
  etag   = filemd5("${var.object_dir}/${each.value}")
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.poc_s3_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.example.iam_arn]
    }
  }
   depends_on = [
    aws_cloudfront_distribution.s3_distribution	
  ]
  }

resource "aws_s3_bucket_policy" "example_policy" {
  bucket = aws_s3_bucket.poc_s3_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
    }



resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
bucket = aws_s3_bucket.poc_s3_bucket.id
lambda_function {
lambda_function_arn = aws_lambda_function.poc_cf_lambda.arn
events              = ["s3:ObjectCreated:*"]
}

}

