# Tokyo provider (default)
provider "aws" {
   region = var.aws_region #"ap-northeast-1"
}

provider "aws" {
   region = "ap-northeast-1"
   alias = "northeast"
}

# # Sao Paulo provider
# provider "aws" {
#   alias  = "saopaulo"
#   region = "sa-east-1"
# }



# provider "aws" {
#   region = var.aws_region
# }
# ## I may need to delete this
# ## 
provider "aws" {
  region = "us-east-1"
  alias = "east"
}