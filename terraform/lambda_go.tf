resource "aws_iam_role" "iam_for_lambda_go" {
  name = "iam_for_lambda_go"

  assume_role_policy = <<EOF
{
  "Version": "2023-01-23",
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

resource "aws_lambda_function" "ssl_lambda_go" {
  filename         = data.archive_file.ssl_lambda_go.output_path
  function_name    = "ssl_checker"
  role             = aws_iam_role.iam_for_lambda_go.arn
  handler          = "../main"
  runtime          = "go1.x"
  source_code_hash = data.archive_file.ssl_lambda_go.output_base64sha256
  depends_on = [
    data.archive_file.ssl_lambda_go
  ]
}
