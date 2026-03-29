# Explanation: Outputs are your mission report—what got built and where to find it.
output "armageddon_vpc_id" {
  value = aws_vpc.armageddon_011826-vpc01.id
}

output "armageddon_public_subnet_ids" {
  value = aws_subnet.armageddon_public-subnets0[*].id
}

output "armageddon_private_subnet_ids" {
  value = aws_subnet.armageddon_private_subnets[*].id
}

output "armageddon_ec2_instance_id" {
  value = aws_instance.chewbacca_ec201_private_bonus.id
}

output "armageddon_rds_endpoint" {
  value = aws_db_instance.armageddon_rds01.address
}

output "armageddon_sns_topic_arn" {
  value = aws_sns_topic.armageddon_sns_topic01.arn
}

output "armageddon_log_group_name" {
  value = aws_cloudwatch_log_group.armageddon_log_group01.name
}
#01292026 Added outputs (append to outputs.tf)
# Explanation: Outputs are the nav computer readout—Chewbacca needs coordinates that humans can paste into browsers.
output "chewbacca_route53_zone_id" {
  value = local.chewbacca_zone_id
}

output "chewbacca_app_url_https" {
  value = "https://${var.app_subdomain}.${var.domain_name}"
}

# Explanation: The apex URL is the front gate—humans type this when they forget subdomains.
# output "chewbacca_apex_url_https" {
#   value = "https://${var.domain_name}"
# }

# # Explanation: Log bucket name is where the footprints live—useful when hunting 5xx or WAF blocks.
# output "chewbacca_alb_logs_bucket_name" {
#   value = var.enable_alb_access_logs ? aws_s3_bucket.chewbacca_alb_logs_bucket01[0].bucket : null
# }

# 
output "chewbacca_waf_log_destination" {
  value = var.waf_log_destination
}

# output "chewbacca_waf_cw_log_group_name" {
#   value = var.waf_log_destination == "cloudwatch" ? aws_cloudwatch_log_group.chewbacca_waf_log_group01[0].name : null
# }

output "chewbacca_waf_logs_s3_bucket" {
  value = var.waf_log_destination == "s3" ? aws_s3_bucket.chewbacca_waf_logs_bucket01[0].bucket : null
}

# output "chewbacca_waf_firehose_name" {
#   value = var.waf_log_destination == "firehose" ? aws_kinesis_firehose_delivery_stream.chewbacca_waf_firehose01[0].name : null
# }