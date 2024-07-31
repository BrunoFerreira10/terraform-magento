data "aws_route53_zone" "hosted_zone" {
  name         = var.domain-base
  private_zone = false
}

resource "aws_route53_record" "record_media" {

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.hosted_zone.zone_id
  name            = "media.${var.domain-base}"
  type            = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront-1.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront-1.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "record_static" {

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.hosted_zone.zone_id
  name            = "static.${var.domain-base}"
  type            = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront-1.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront-1.hosted_zone_id
    evaluate_target_health = true
  }
}