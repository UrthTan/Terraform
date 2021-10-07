resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.domain_urthtan.zone_id
  name    = "apps.urthtan.com"
  type    = "A"
  # ttl = "300" # Only needed if there is no alias
  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}

# resource "aws_route53_record" "app1_dns" {
#   zone_id = data.aws_route53_zone.domain_urthtan.zone_id
#   name    = var.app1_dns_name
#   type    = "A"
#   # ttl = "300" # Only needed if there is no alias
#   alias {
#     name                   = module.alb.lb_dns_name
#     zone_id                = module.alb.lb_zone_id
#     evaluate_target_health = true
#   }
# }

# resource "aws_route53_record" "app2_dns" {
#   zone_id = data.aws_route53_zone.domain_urthtan.zone_id
#   name    = var.app2_dns_name
#   type    = "A"
#   # ttl = "300" # Only needed if there is no alias
#   alias {
#     name                   = module.alb.lb_dns_name
#     zone_id                = module.alb.lb_zone_id
#     evaluate_target_health = true
#   }
# }

resource "aws_route53_record" "app2_dns" {
  zone_id = data.aws_route53_zone.domain_urthtan.zone_id
  name    = var.azure_dns_name
  type    = "A"
  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}