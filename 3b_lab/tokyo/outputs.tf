# Explanation: Outputs are your mission coordinates—what got built and where to find it.
output "shinjuku_vpc_id" {
  value = aws_vpc.shinjuku_011826-vpc01.id
}

output "shinjuku_vpc_cidr" {
  value = var.vpc_cidr
}

output "shinjuku_private_subnet_ids" {
  value = aws_subnet.shinjuku_private_subnets[*].id
}

output "shinjuku_tgw_id" {
  value = aws_ec2_transit_gateway.shinjuku_tgw01.id
}

output "shinjuku_tgw_peering_attachment_id" {
  value = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade_peer01.id
}

output "shinjuku_rds_endpoint" {
  description = "Tokyo RDS endpoint — uncomment once RDS is deployed"
  value       = aws_db_instance.shinjuku_rds01.address # TODO: replace with aws_db_instance.shinjuku_rds01.address
}

# output "shinjuku_private_ec2_instance_id_bonus" {
#   value = aws_instance.shinjuku_ec201_private_bonus.id
# 

# output "shinjuku_vpce_ssm_id" {
#   value = aws_vpc_endpoint.shinjuku_vpce_ssm01.id
# }

# output "shinjuku_vpce_logs_id" {
#   value = aws_vpc_endpoint.shinjuku_vpce_logs01.id
# }

# output "shinjuku_vpce_secrets_id" {
#   value = aws_vpc_endpoint.shinjuku_vpce_secrets01.id
# }

# output "shinjuku_vpce_s3_id" {
#   value = aws_vpc_endpoint.shinjuku_vpce_s3_gw01.id
# }

output "shinjuku_app_url_https" {
  value = "https://${var.app_subdomain}.${var.domain_name}"
}

# output "shinjuku_acm_cert_arn" {
#   value = aws_acm_certificate.shinjuku_acm_cert01.arn
# }

# output "shinjuku_alb_dns_name" {
#   value = aws_lb.shinjuku_alb01.dns_name
# }

# output "shinjuku_app_fqdn" {
#   value = "${var.app_subdomain}.${var.domain_name}"
# }

# output "shinjuku_target_group_arn" {
#   value = aws_lb_target_group.shinjuku_tg01.arn
# }

# output "shinjuku_waf_arn" {
#   value = var.enable_waf ? aws_wafv2_web_acl.shinjuku_waf01[0].arn : null
# }

# output "shinjuku_dashboard_name" {
#   value = aws_cloudwatch_dashboard.shinjuku_dashboard01.dashboard_name
# }
