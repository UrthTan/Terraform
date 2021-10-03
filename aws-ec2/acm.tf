module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 3.0"

  domain_name = trimsuffix(data.aws_route53_zone.domain_urthtan.name, ".")
  zone_id     = data.aws_route53_zone.domain_urthtan.zone_id

  subject_alternative_names = [
    "*.urthtan.com"
  ]

  wait_for_validation = true

  tags = local.common_tags
}

# Output ACM Certificate ARN
output "acm_certificate_arn" {
  description = "ACM Certificate ARN"
  value       = module.acm.acm_certificate_arn
}