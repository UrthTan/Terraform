# Get DNS information from AWS Route53
data "aws_route53_zone" "domain_urthtan" {
  name = "urthtan.com"
}

# Output MyDomain Zone ID
output "domain_zone_id" {
  description = "The Hosted Zone id of the desired Hosted Zone"
  value       = data.aws_route53_zone.domain_urthtan.zone_id
}