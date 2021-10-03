# Terraform AWS Classic Load Balancer (ELB-CLB)
module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "2.5.0"
  name    = "${local.name}-elb"
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  security_groups     = [module.loadbalancer_sg.security_group_id]
  number_of_instances = var.private_instance_count
  instances = [
    module.ec2_private_app1.id[0],
    module.ec2_private_app1.id[1]
  ]
  listener = [
    {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    },
    {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 81
      lb_protocol       = "http"
    }
  ]
  health_check = {
    target              = "http:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
  tags = local.common_tags
}