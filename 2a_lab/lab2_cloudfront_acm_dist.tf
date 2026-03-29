# # # Explanation: TLS is the diplomatic passport — browsers trust you, and Chewbacca stops growling at plaintext.
resource "aws_acm_certificate" "chewbacca_acm_app_to_cf01" {
  provider          = aws.east
  domain_name       = "${var.app_subdomain}.${var.domain_name}"
  validation_method = var.certificate_validation_method
  subject_alternative_names = [var.domain_name]

  lifecycle {
    create_before_destroy = true
  }
}
# TODO: students implement aws_route53_record(s) if they manage DNS in Route53.
resource "aws_route53_record" "armageddon_acm_cf_validation" {

  for_each = {
    for dvo in aws_acm_certificate.chewbacca_acm_app_to_cf01.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.armageddon_existing_zone01.zone_id #local.chewbacca_zone_id
  name            = each.value.name
  type            = each.value.type
  ttl             = 60

  records = [each.value.record]

}

resource "aws_acm_certificate_validation" "chewbacca_acm_cf_validation01" {
  provider        = aws.east  
  certificate_arn = aws_acm_certificate.chewbacca_acm_app_to_cf01.arn
  validation_record_fqdns      = [for r in aws_route53_record.armageddon_acm_cf_validation:r.fqdn]

}