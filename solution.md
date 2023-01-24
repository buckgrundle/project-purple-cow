Terraform will perform the following actions:

aws_dynamodb_table.state_lock will be created
+ resource "aws_dynamodb_table" "state_lock" {
    + arn              = (known after apply)
    + billing_mode     = "PROVISIONED"
    + hash_key         = "LockID"
    + id               = (known after apply)
    + name             = "TerraformState"
    + read_capacity    = 5
    + stream_arn       = (known after apply)
    + stream_label     = (known after apply)
    + stream_view_type = (known after apply)
    + tags_all         = (known after apply)
    + write_capacity   = 5

    + attribute {
        + name = "LockID"
        + type = "S"
          }

    + point_in_time_recovery {
        + enabled = (known after apply)
          }

    + server_side_encryption {
        + enabled     = (known after apply)
        + kms_key_arn = (known after apply)
          }

    + ttl {
        + attribute_name = (known after apply)
        + enabled        = (known after apply)
          }
          }

aws_iam_role.iam_for_lambda_go will be created
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

aws_iam_role.iam_for_lambda_py will be created
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

aws_lambda_function.ssl_lambda will be created
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
    + source_code_hash               = "bDATswnGw/Soh42SRnPJA42YaoGgpMmE+4zFBWwecH0="
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

aws_lambda_function.ssl_lambda_go will be created
+ resource "aws_lambda_function" "ssl_lambda_go" {
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
    + source_code_hash               = "b+Kq5S7oc4TRbYn7Gz4SV9wCJa7G8cJR9IjXA0UpraE="
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

Plan: 5 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────"
