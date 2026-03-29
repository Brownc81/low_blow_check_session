variable "aws_region" {
  description = "AWS Region for the liberdade fleet to patrol."
  type        = string
  default     = "sa-east-1"
}

variable "project_name" {
  description = "Prefix for naming. Students should change from 'liberdade' to their own."
  type        = string
  default     = "liberdade"
}

variable "vpc_cidr" {
  description = "VPC CIDR (use 10.x.x.x/xx as instructed)."
  type        = string
  default     = "10.162.0.0/16" # TODO: student supplies, 0118 3:28
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs (use 10.x.x.x/xx)."
  type        = list(string)
  default     = ["10.162.1.0/24", "10.162.2.0/24"] # TODO: student supplies, 0118 4:43
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs (use 10.x.x.x/xx)."
  type        = list(string)
  default     = ["10.162.11.0/24", "10.162.12.0/24"] # TODO: student supplies, 0118 4:45
}

variable "azs" {
  description = "Availability Zones list (match count with subnets)."
  type        = list(string)
  default     = ["sa-east-1a", "sa-east-1b"] # TODO: student supplies 0118 1010
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 app host."
  type        = string
  default     = "ami-06a73f9d93a3879b5" # TODO 0118 1018
}

variable "ec2_instance_type" {
  description = "EC2 instance size for the app."
  type        = string
  default     = "t3.micro"
}

variable "db_engine" {
  description = "RDS engine."
  type        = string
  default     = "mysql"
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "labdb" # Students can change
}

variable "db_username" {
  description = "DB master username (students should use Secrets Manager in 1B/1C)."
  type        = string
  default     = "admin" # TODO: student supplies 0118 1000
}

variable "db_password" {
  description = "DB master password (DO NOT hardcode in real life; for lab only)."
  type        = string
  sensitive   = true
  default     = "Putituplion45" # TODO: student supplies 0118 1000
}

variable "sns_email_endpoint" {
  description = "Email for SNS subscription (PagerDuty simulation)."
  type        = string
  default     = "charlesbrownii651@gmail.com" # TODO: student supplies 0118 1001
}

variable "manage_route53_in_terraform" {
  description = "If true, create/manage Route53 hosted zone + records in Terraform."
  type        = bool
  default     = false
}

variable "route53_hosted_zone_id" {
  description = "If managSe_route53_in_terraform=false, provide existing Hosted Zone ID for domain."
  type        = string
  default     = "Z09932322KNUVXOPUACQX"
}
variable "enable_alb_access_logs" {
  description = "Enable ALB access logging to S3."
  type        = bool
  default     = true
}

variable "alb_access_logs_prefix" {
  description = "S3 prefix for ALB access logs."
  type        = string
  default     = "alb-access-logs"
}
# 02012026 append for 1c_bonus-E.md
variable "waf_log_destination" {
  description = "Choose ONE destination per WebACL: cloudwatch | s3 | firehose"
  type        = string
  default     = "cloudwatch"
}

variable "waf_log_retention_days" {
  description = "Retention for WAF CloudWatch log group."
  type        = number
  default     = 14
}

variable "enable_waf_sampled_requests_only" {
  description = "If true, students can optionally filter/redact fields later. (Placeholder toggle.)"
  type        = bool
  default     = false
}
#020426 lab2_cloudfront_shield_waf.tf
variable "cloudfront_acm_cert_arn" {
  description = "ACM certificate ARN in us-east-1 for CloudFront (covers liberdade-growl.com and app.liberdade-growl.com)."
  type        = string
  default = "arn:aws:acm:us-east-1:400398151894:certificate/716194a5-2138-4aaf-8f2f-079e8854c71b"
}  
variable "tokyo_vpc_cidr" {
  description = "Tokyo VPC CIDR — used for TGW routes pointing to RDS."
  type        = string
  default     = "10.161.0.0/16"
}

variable "shinjuku_peering_attachment_id" {
  description = "Tokyo TGW peering attachment ID — copy from Tokyo outputs after Tokyo TGW apply."
  type        = string
  default     = "tgw-attach-0c39898968304ebd6" # TODO: paste shinjuku_tgw_peering_attachment_id output from Tokyo after apply
}