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