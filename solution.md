### Solution

For this assignment I decided to first re-write the Lambda entirely in Go as it has been my primary coding language
for the past 4 years. In the interest of time and trying to comply with the two hour constraint, it was a better decision
to re-write it quickly than to re-learn Python.

The updated Terraform code lives in the `terraform` directory. Running a `terraform plan` will first build .zip files 
for both the Go and Python Lambdas, then calculate the values for all the resources for the API gateway. The output of running a
successful `terraform plan` on my AWS account is below.

### Running the Go Lambda locally
1. Check out the repo
2. run `go mod vendor` and `go mod tidy` to get the dependencies
3. run `go run main.go` to start the server on port 3000
4. open a browser and go to `http://localhost:3000/ssl-checker?host=google.com`

### Running the Terraform
1. Check out the repo
2. To run locally, you will need to export both `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as environment variables
3. Run `terraform init` to get the dependencies
4. Run `terraform plan` to see what will be created

Example output from `terraform plan`:

```
Terraform will perform the following actions:

  # aws_api_gateway_deployment.ssl_checker will be created
  + resource "aws_api_gateway_deployment" "ssl_checker" {
      + created_date  = (known after apply)
      + execution_arn = (known after apply)
      + id            = (known after apply)
      + invoke_url    = (known after apply)
      + rest_api_id   = (known after apply)
      + stage_name    = "test"
    }

  # aws_api_gateway_integration.ssl_checker_lambda will be created
  + resource "aws_api_gateway_integration" "ssl_checker_lambda" {
      + cache_namespace         = (known after apply)
      + connection_type         = "INTERNET"
      + http_method             = "ANY"
      + id                      = (known after apply)
      + integration_http_method = "POST"
      + passthrough_behavior    = (known after apply)
      + resource_id             = (known after apply)
      + rest_api_id             = (known after apply)
      + timeout_milliseconds    = 29000
      + type                    = "AWS_PROXY"
      + uri                     = (known after apply)
    }

  # aws_api_gateway_integration.ssl_checker_lambda_root will be created
  + resource "aws_api_gateway_integration" "ssl_checker_lambda_root" {
      + cache_namespace         = (known after apply)
      + connection_type         = "INTERNET"
      + http_method             = "ANY"
      + id                      = (known after apply)
      + integration_http_method = "POST"
      + passthrough_behavior    = (known after apply)
      + resource_id             = (known after apply)
      + rest_api_id             = (known after apply)
      + timeout_milliseconds    = 29000
      + type                    = "AWS_PROXY"
      + uri                     = (known after apply)
    }

  # aws_api_gateway_method.proxy will be created
  + resource "aws_api_gateway_method" "proxy" {
      + api_key_required = false
      + authorization    = "NONE"
      + http_method      = "ANY"
      + id               = (known after apply)
      + resource_id      = (known after apply)
      + rest_api_id      = (known after apply)
    }

  # aws_api_gateway_method.proxy_root will be created
  + resource "aws_api_gateway_method" "proxy_root" {
      + api_key_required = false
      + authorization    = "NONE"
      + http_method      = "ANY"
      + id               = (known after apply)
      + resource_id      = (known after apply)
      + rest_api_id      = (known after apply)
    }

  # aws_api_gateway_resource.ssl_checker will be created
  + resource "aws_api_gateway_resource" "ssl_checker" {
      + id          = (known after apply)
      + parent_id   = (known after apply)
      + path        = (known after apply)
      + path_part   = "{proxy+}"
      + rest_api_id = (known after apply)
    }

  # aws_api_gateway_rest_api.ssl_checker will be created
  + resource "aws_api_gateway_rest_api" "ssl_checker" {
      + api_key_source               = (known after apply)
      + arn                          = (known after apply)
      + binary_media_types           = (known after apply)
      + created_date                 = (known after apply)
      + description                  = (known after apply)
      + disable_execute_api_endpoint = (known after apply)
      + execution_arn                = (known after apply)
      + id                           = (known after apply)
      + minimum_compression_size     = -1
      + name                         = "ssl_checker"
      + policy                       = (known after apply)
      + root_resource_id             = (known after apply)
      + tags_all                     = (known after apply)

      + endpoint_configuration {
          + types            = (known after apply)
          + vpc_endpoint_ids = (known after apply)
        }
    }

  # aws_iam_role.iam_for_lambda_go will be created
  + resource "aws_iam_role" "iam_for_lambda_go" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "lambda.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2023-01-23"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "iam_for_lambda_go"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # aws_iam_role.iam_for_lambda_py will be created
  + resource "aws_iam_role" "iam_for_lambda_py" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "lambda.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2023-01-23"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "iam_for_lambda_py"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # aws_lambda_function.ssl_checker_lambda_go will be created
  + resource "aws_lambda_function" "ssl_checker_lambda_go" {
      + architectures                  = (known after apply)
      + arn                            = (known after apply)
      + filename                       = "./files/lambda_go.zip"
      + function_name                  = "ssl_checker"
      + handler                        = "../main"
      + id                             = (known after apply)
      + invoke_arn                     = (known after apply)
      + last_modified                  = (known after apply)
      + memory_size                    = 128
      + package_type                   = "Zip"
      + publish                        = false
      + qualified_arn                  = (known after apply)
      + qualified_invoke_arn           = (known after apply)
      + reserved_concurrent_executions = -1
      + role                           = (known after apply)
      + runtime                        = "go1.x"
      + signing_job_arn                = (known after apply)
      + signing_profile_version_arn    = (known after apply)
      + source_code_hash               = "duLxpDNsmsBWkmWcKrNaraETDgQmz2TPF0Z0JD9IU9M="
      + source_code_size               = (known after apply)
      + tags_all                       = (known after apply)
      + timeout                        = 3
      + version                        = (known after apply)

      + ephemeral_storage {
          + size = (known after apply)
        }

      + tracing_config {
          + mode = (known after apply)
        }
    }

  # aws_lambda_function.ssl_lambda will be created
  + resource "aws_lambda_function" "ssl_lambda" {
      + architectures                  = (known after apply)
      + arn                            = (known after apply)
      + filename                       = "./files/lambda_py.zip"
      + function_name                  = "ssl_checker"
      + handler                        = "main.ssl_cert_check_handler"
      + id                             = (known after apply)
      + invoke_arn                     = (known after apply)
      + last_modified                  = (known after apply)
      + memory_size                    = 128
      + package_type                   = "Zip"
      + publish                        = false
      + qualified_arn                  = (known after apply)
      + qualified_invoke_arn           = (known after apply)
      + reserved_concurrent_executions = -1
      + role                           = (known after apply)
      + runtime                        = "python3.9"
      + signing_job_arn                = (known after apply)
      + signing_profile_version_arn    = (known after apply)
      + source_code_hash               = "wGWNypgtn9fNXNMEZOuQuM6ZyNwGdLVLsX10mOCIfQA="
      + source_code_size               = (known after apply)
      + tags_all                       = (known after apply)
      + timeout                        = 3
      + version                        = (known after apply)

      + ephemeral_storage {
          + size = (known after apply)
        }

      + tracing_config {
          + mode = (known after apply)
        }
    }

  # aws_lambda_permission.allow_api_gateway will be created
  + resource "aws_lambda_permission" "allow_api_gateway" {
      + action              = "lambda:InvokeFunction"
      + function_name       = "ssl_checker"
      + id                  = (known after apply)
      + principal           = "apigateway.amazonaws.com"
      + source_arn          = (known after apply)
      + statement_id        = "AllowAPIGatewayInvoke"
      + statement_id_prefix = (known after apply)
    }

Plan: 12 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + api_gateway_url = (known after apply)

─────────────────────────────────────────────────────────────────────────────────────────────────────
```
