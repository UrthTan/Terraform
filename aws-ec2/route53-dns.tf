resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.domain_urthtan.zone_id
  name    = "apps.urthtan.com"
  type    = "A"
  # ttl = "300" # Only needed if there is no alias
  alias {
    name                   = module.alb.this_lb_dns_name
    zone_id                = module.alb.this_lb_zone_id
    evaluate_target_health = true
  }
}