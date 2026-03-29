terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use latest version if possible
    }
  }

  backend "s3" {
    bucket  = "statefilewebhook032226"                 #032226Name of the S3 bucket
    key     = "jenkins-test-031726.tfstate"        # The name of the state file in the bucket
    region  = "us-east-1"                          # Use a variable for the region
    encrypt = true                                 # Enable server-side encryption (optional but recommended)
  } 
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_s3_bucket" "frontend" {
  bucket_prefix = "jenkins-bucket-"
  force_destroy = true
  

  tags = {
    Name = "Jenkins Bucket"
  }
}
resource "aws_s3_bucket_public_access_block" "frontend_public_access" {
  bucket = aws_s3_bucket.frontend.bucket
 
 
 
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.frontend.bucket
 
  depends_on = [aws_s3_bucket_public_access_block.frontend_public_access]
 
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.frontend.arn}/*"
      }
    ]
  })
}
resource "aws_s3_object" "object1" {
  bucket = aws_s3_bucket.frontend.bucket
  key    = "images/class7continuesproof.png"
  source = "${path.module}/class7continuesproof.png"
  content_type = "image/png"
  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("./class7continuesproof.png")
}
resource "aws_s3_object" "object2" {
  bucket = aws_s3_bucket.frontend.bucket
  key    = "images/webhooktigger.png"
  source = "${path.module}/webhooktigger.png"
  content_type = "image/png"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("./webhooktigger.png")
}
resource "aws_s3_object" "object3" {
  bucket = aws_s3_bucket.frontend.bucket
  key    = "images/armageddon_repo_link.md"
  source = "${path.module}/armageddon_repo_link.md"
  content_type = "text/markdown; charset_utf-8"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("./armageddon_repo_link.md")
}

resource "aws_s3_object" "object4" {
  bucket = aws_s3_bucket.frontend.bucket
  key    = "images/jenconle.png"
  source = "${path.module}/jenconle.png"
  content_type = "image/png"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("./jenconle.png")
}

resource "aws_s3_bucket_website_configuration" "frontend_website" {
   bucket = aws_s3_bucket.frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
