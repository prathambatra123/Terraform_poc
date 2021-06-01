resource "aws_iam_role" "iam_for_lambda" {
  name = var.role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_basic_policy" {
  name   = var.lambda_basic_policy_name
  role   = aws_iam_role.iam_for_lambda.id
  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:${var.region}:${var.ACCOUNT_NUMBER}:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:${var.region}:${var.ACCOUNT_NUMBER}:log-group:/aws/lambda/aws_lambda_function.poc_cf_lambda:*"
            ]
        }
    ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "iam_policy_cloudfront_attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
}
