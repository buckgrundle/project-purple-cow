output "api_gateway_url" {
  value = aws_api_gateway_deployment.ssl_checker.invoke_url
}

resource "aws_api_gateway_rest_api" "ssl_checker" {
  name = "ssl_checker"
}

resource "aws_api_gateway_resource" "ssl_checker" {
  rest_api_id = aws_api_gateway_rest_api.ssl_checker.id
  parent_id   = aws_api_gateway_rest_api.ssl_checker.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  authorization = "NONE"
  http_method   = "ANY"
  resource_id   = aws_api_gateway_resource.ssl_checker.id
  rest_api_id   = aws_api_gateway_rest_api.ssl_checker.id
}

resource "aws_api_gateway_integration" "ssl_checker_lambda" {
  http_method             = aws_api_gateway_method.proxy.http_method
  resource_id             = aws_api_gateway_method.proxy.resource_id
  rest_api_id             = aws_api_gateway_method.proxy.rest_api_id
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.ssl_checker_lambda_go.invoke_arn
}

resource "aws_api_gateway_method" "proxy_root" {

  authorization = "NONE"
  http_method   = "ANY"
  resource_id   = aws_api_gateway_rest_api.ssl_checker.root_resource_id
  rest_api_id   = aws_api_gateway_rest_api.ssl_checker.id
}

resource "aws_api_gateway_integration" "ssl_checker_lambda_root" {
  http_method             = aws_api_gateway_method.proxy_root.http_method
  resource_id             = aws_api_gateway_method.proxy_root.resource_id
  rest_api_id             = aws_api_gateway_rest_api.ssl_checker.id
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.ssl_checker_lambda_go.invoke_arn
}

resource "aws_api_gateway_deployment" "ssl_checker" {
  depends_on  = [aws_api_gateway_integration.ssl_checker_lambda]
  rest_api_id = aws_api_gateway_rest_api.ssl_checker.id
  stage_name  = "test"
}
