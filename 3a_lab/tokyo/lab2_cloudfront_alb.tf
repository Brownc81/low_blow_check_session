# Explanation: CloudFront is the only public doorway — shinjuku stands behind it with private infrastructure.
resource "aws_cloudfront_distribution" "shinjuku_cf01" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "${var.project_name}-cf01"

  origin {
    origin_id   = "${var.project_name}-alb-origin01"
    domain_name = aws_lb.shinjuku_alb01.dns_name

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    # Explanation: CloudFront whispers the secret growl — the ALB only trusts this.
    custom_header {
      name  = "X-shinjuku-Growl"
      value = random_password.shinjuku_origin_header_value01.result
    }
  }

 
   # --- 2. Aliases & Certificates ---
  aliases = [
    var.domain_name,
    "${var.app_subdomain}.${var.domain_name}"
  ]

  viewer_certificate {
    acm_certificate_arn      =  aws_acm_certificate.shinjuku_acm_app_to_cf01.arn#aws_acm_certificate_validation.shinjuku_cf_validation01.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  default_cache_behavior {
  target_origin_id       = "${var.project_name}-alb-origin01"
  viewer_protocol_policy = "redirect-to-https"

  allowed_methods = ["GET","HEAD","OPTIONS","PUT","POST","PATCH","DELETE"]
  cached_methods  = ["GET","HEAD"]

  min_ttl = 0
  default_ttl = 0
  max_ttl = 0
  
  cache_policy_id          = data.aws_cloudfront_cache_policy.caching_disabled.id
  origin_request_policy_id = data.aws_cloudfront_origin_request_policy.shinjuku_orp_all_viewer01.id
}

# Explanation: Static behavior is the speed lane—shinjuku caches it hard for performance.
ordered_cache_behavior {
  path_pattern           = "/static/*"
  target_origin_id       = "${var.project_name}-alb-origin01"
  viewer_protocol_policy = "redirect-to-https"

  allowed_methods = ["GET","HEAD","OPTIONS"]
  cached_methods  = ["GET","HEAD"]

  cache_policy_id            = aws_cloudfront_cache_policy.shinjuku_cache_static01.id
  origin_request_policy_id   = aws_cloudfront_origin_request_policy.shinjuku_orp_static01.id
  response_headers_policy_id = aws_cloudfront_response_headers_policy.shinjuku_rsp_static01.id
}

# ############################################
# # Lab 2B-Honors - a) /api/public-feed = origin-driven caching
# ############################################

 ordered_cache_behavior {
  path_pattern           = "/api/public-feed"
  target_origin_id       = "${var.project_name}-alb-origin01"
  viewer_protocol_policy = "redirect-to-https"

  allowed_methods = ["GET", "HEAD", "OPTIONS"]
  cached_methods  = ["GET", "HEAD"]

  # Honor Cache-Control from origin (and default to not caching without it). :contentReference[oaicite:8]{index=8}
  cache_policy_id = data.aws_cloudfront_cache_policy.shinjuku_use_origin_cache_headers01.id

  # Forward what origin needs. Keep it tight: don't forward everything unless required. :contentReference[oaicite:9]{index=9}
  origin_request_policy_id = data.aws_cloudfront_origin_request_policy.shinjuku_orp_all_viewer_except_host01.id
}



# ############################################
# # Lab 2B-Honors - B) /api/* = still safe default (no caching)
# ############################################

# # Explanation: Everything else under /api is dangerous by default—shinjuku disables caching until proven safe.
ordered_cache_behavior {
  path_pattern           = "/api/*"
  target_origin_id       = "${var.project_name}-alb-origin01"
  viewer_protocol_policy = "redirect-to-https"

  allowed_methods = ["GET","HEAD","OPTIONS","PUT","POST","PATCH","DELETE"]
  cached_methods  = ["GET","HEAD"]

  cache_policy_id          = data.aws_cloudfront_cache_policy.shinjuku_use_origin_cache_headers_qs01.id
  origin_request_policy_id = data.aws_cloudfront_origin_request_policy.shinjuku_orp_all_viewer01.id
}

  # Explanation: Attach WAF at the eddata.aws_cloudfront_origin_request_policy.shinjuku_orp_all_viewer01.idge — now WAF moved to CloudFront.
  web_acl_id = aws_wafv2_web_acl.shinjuku_cf_waf01.arn

 

  # TODO: students must use ACM cert in us-east-1 for CloudFront
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}