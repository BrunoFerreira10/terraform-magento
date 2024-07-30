// Hosted Zone
data "aws_route53_zone" "hosted_zone" {
  name         = var.domain-base
  private_zone = false
}

// DNS Record - A
resource "aws_route53_record" "record_A" {

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.hosted_zone.zone_id
  name            = var.domain-base
  type            = "A"

  alias {
    name                   = aws_lb.alb-1.dns_name
    zone_id                = aws_lb.alb-1.zone_id
    evaluate_target_health = true
  }
}

// DNS Record - CNAME - www
resource "aws_route53_record" "record_WWW" {

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.hosted_zone.zone_id
  name            = "www.${var.domain-base}"
  type            = "A"

  alias {
    name                   = aws_lb.alb-1.dns_name
    zone_id                = aws_lb.alb-1.zone_id
    evaluate_target_health = true
  }
}