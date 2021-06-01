data "archive_file" "zipit" {
  type        = "zip"
  source_file = "module/s3_static_website/cf.py"
  output_path = "${var.lambda_name}.zip"
}

resource "aws_lambda_function" "poc_cf_lambda" {
  filename      = data.archive_file.zipit.output_path
  function_name = var.lambda_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler = "cf.lambda_handler"
  runtime = "python3.8"

  environment {
    variables = {
      distribution_id = aws_cloudfront_distribution.s3_distribution.id
    }
  }
  
}


resource "aws_lambda_permission" "aws-lambda-trigger-permission" {
statement_id  = "AllowExecutionFromS3Bucket"
action        = "lambda:InvokeFunction"
function_name = aws_lambda_function.poc_cf_lambda.arn
principal = "s3.amazonaws.com"
source_arn = aws_s3_bucket.poc_s3_bucket.arn
}
