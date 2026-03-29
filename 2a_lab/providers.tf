provider "aws" {
  region = var.aws_region
}

## I may need to delete this
provider "aws" {
  region = "us-east-1"
  alias = "east"
}
