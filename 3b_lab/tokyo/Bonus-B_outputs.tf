# #Explanation: Outputs are the mission coordinates — where to point your browser and your blasters.
output "shinjuku_alb_dns_name" {
  value = aws_lb.shinjuku_alb01.dns_name
}

output "shinjuku_app_fqdn" {
  value = "${var.app_subdomain}.${var.domain_name}"
}

output "shinjuku_target_group_arn" {
  value = aws_lb_target_group.shinjuku_tg01.arn
}

output "shinjuku_acm_cert_arn" {
  value = aws_acm_certificate.shinjuku_acm_cert01.arn
}

output "shinjuku_waf_arn" {
  value = var.enable_waf ? aws_wafv2_web_acl.shinjuku_waf01[0].arn : null
}

output "shinjuku_dashboard_name" {
  value = aws_cloudwatch_dashboard.shinjuku_dashboard01.dashboard_name
}
