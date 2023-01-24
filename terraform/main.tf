terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "tf-refresh"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "TerraformState"
  }
}

resource "aws_dynamodb_table" "state_lock" {
  name           = "TerraformState"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }
}
