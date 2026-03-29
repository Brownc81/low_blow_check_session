# # # # Explanation: I need to add this to Need more details on way I added this
# resource "aws_acm_certificate" "liberdade_acm_app_to_cf01" {
#   provider          = aws.east
#   domain_name       = "${var.app_subdomain}.${var.domain_name}"
#   validation_method = var.certificate_validation_method
#   subject_alternative_names = [var.domain_name]

#   lifecycle {
#     create_before_destroy = true
#   }
# }
# # 
# resource "aws_route53_record" "liberdade_acm_cf_validation" {

#   for_each = {
#     for dvo in aws_acm_certificate.liberdade_acm_app_to_cf01.domain_validation_options :
#     dvo.domain_name => {
#       name   = dvo.resource_record_name
#       type   = dvo.resource_record_type
#       record = dvo.resource_record_value
#     }
#   }

#   allow_overwrite = true
#   zone_id         = data.aws_route53_zone.liberdade_existing_zone01.zone_id #local.liberdade_zone_id
#   name            = each.value.name
#   type            = each.value.type
#   ttl             = 60

#   records = [each.value.record]

# }

# resource "aws_acm_certificate_validation" "liberdade_acm_cf_validation01" {
#   provider        = aws.east  
#   certificate_arn = aws_acm_certificate.liberdade_acm_app_to_cf01.arn
#   validation_record_fqdns      = [for r in aws_route53_record.liberdade_acm_cf_validation:r.fqdn]

# }