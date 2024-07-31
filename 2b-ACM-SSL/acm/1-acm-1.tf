// DNS
data "aws_route53_zone" "hosted-zone" {
  name         = var.domain-base
  private_zone = false
}

// ACM SSL Certificate
resource "aws_acm_certificate" "certificate-1" {
  domain_name       = var.domain-base
  validation_method = "DNS"

  subject_alternative_names = [
    "www.${var.domain-base}"
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "certificate-${var.shortnameid}-1"
  }
}

// DNS Record - Certificate validation
resource "aws_route53_record" "validation-records-certificate-1" {
  for_each = {
    for dvo in aws_acm_certificate.certificate-1.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type

      tags = {
        Name = "certificate-${var.shortnameid}-1-${dvo.resource_record_name}"
      }
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.hosted-zone.zone_id

}

// Certificate validation
resource "aws_acm_certificate_validation" "certificate-1-validation" {
  certificate_arn = aws_acm_certificate.certificate-1.arn
  validation_record_fqdns = [
    for record in aws_route53_record.validation-records-certificate-1 : record.fqdn
  ]
}