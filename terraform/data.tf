data "archive_file" "ssl_lambda_py" {
  type             = "zip"
  output_path      = "${path.module}/files/lambda_py.zip"
  source_dir       = "${path.module}/../python"
  output_file_mode = "0666"
}

data "archive_file" "ssl_lambda_go" {
  type             = "zip"
  output_path      = "${path.module}/files/lambda_go.zip"
  source_dir       = "${path.module}/../"
  output_file_mode = "0666"
}
