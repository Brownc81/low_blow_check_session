# #Explanation: Outputs are the mission coordinates — where to point your browser and your blasters.
# output "liberdade_alb_dns_name" {
#   value = aws_lb.liberdade_alb01.dns_name
# }

# output "liberdade_app_fqdn" {
#   value = "${var.app_subdomain}.${var.domain_name}"
# }

# output "liberdade_target_group_arn" {
#   value = aws_lb_target_group.liberdade_tg01.arn
# }

# output "liberdade_acm_cert_arn" {
#   value = aws_acm_certificate.liberdade_acm_cert01.arn
# }

# output "liberdade_waf_arn" {
#   value = var.enable_waf ? aws_wafv2_web_acl.liberdade_waf01[0].arn : null
# }

# output "liberdade_dashboard_name" {
#   value = aws_cloudwatch_dashboard.liberdade_dashboard01.dashboard_name
# }
