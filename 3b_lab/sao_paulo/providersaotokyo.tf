# Tokyo provider (default)
# provider "aws" {
#   region = "ap-northeast-1"
# }

# # Sao Paulo provider
provider "aws" {
  alias  = "saopaulo"
  region = "sa-east-1"
}
provider "aws" {
  region = "us-east-1"
  alias = "east"
}