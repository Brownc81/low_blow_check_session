# Explanation: Outputs are your mission report—what got built and where to find it.
# output "liberdade_vpc_id" {
#   value = aws_vpc.liberdade_011826-vpc01.id
# }

# output "liberdade_public_subnet_ids" {
#   value = aws_subnet.liberdade_public-subnets0[*].id
# }

# output "liberdade_private_subnet_ids" {
#   value = aws_subnet.liberdade_private_subnets[*].id
# }

# # output "liberdade_ec2_instance_id" {
# #   value = aws_instance.liberdade_ec201_private_bonus.id
# # }

# # output "liberdade_rds_endpoint" {
# #   value = aws_db_instance.liberdade_rds01.address
# # }

# output "liberdade_sns_topic_arn" {
#   value = aws_sns_topic.liberdade_sns_topic01.arn
# }

# output "liberdade_log_group_name" {
#   value = aws_cloudwatch_log_group.liberdade_log_group01.name
# }
# # 01292026 Added outputs (append to outputs.tf)
# # Explanation: Outputs are the nav computer readout—liberdade needs coordinates that humans can paste into browsers.
# output "liberdade_route53_zone_id" {
#   value = local.liberdade_zone_id
# }

output "liberdade_app_url_https" {
  value = "https://${var.app_subdomain}.${var.domain_name}"
}