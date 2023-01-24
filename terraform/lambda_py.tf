resource "aws_iam_role" "iam_for_lambda_py" {
  name = "iam_for_lambda_py"

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

resource "aws_lambda_function" "ssl_lambda" {
  filename         = data.archive_file.ssl_lambda_py.output_path
  function_name    = "ssl_checker"
  role             = aws_iam_role.iam_for_lambda_py.arn
  handler          = "main.ssl_cert_check_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.ssl_lambda_py.output_base64sha256
  depends_on = [
    data.archive_file.ssl_lambda_py
  ]
}
