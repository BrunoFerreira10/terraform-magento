// Hosted Zone
data "aws_route53_zone" "hosted_zone" {
  name         = var.domain-base
  private_zone = false
}

# DNS Record - A - record_setup
resource "aws_route53_record" "record_setup" {

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.hosted_zone.zone_id
  name            = "setup.${var.domain-base}"
  type            = "A"
  ttl             = 60
  records         = [aws_instance.ec2-setup.public_ip]
}

# // DNS Record - A
# resource "aws_route53_record" "record_A" {

#   allow_overwrite = true
#   zone_id         = data.aws_route53_zone.hosted_zone.zone_id
#   name            = var.domain-base
#   type            = "A"
#   ttl             = 60
#   records         = [aws_instance.ec2-setup.public_ip]
# }

// DNS Record - CNAME - www
# resource "aws_route53_record" "record_WWW" {

#   allow_overwrite = true
#   zone_id         = data.aws_route53_zone.hosted_zone.zone_id
#   name            = "www.${var.domain-base}"
#   type            = "A"
#   ttl             = 60
#   records         = [aws_instance.ec2-setup.public_ip]
# }