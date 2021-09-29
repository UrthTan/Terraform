# AWS EC2 Security Group Terraform Module
# Security Group for Load Balancer
module "loadbalancer_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.3.0"

  name        = "loadbalancer_sg"
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Block  
  # List of ingress rules to create by name
  ingress_rules = ["http-80-tcp"]
  # List of IPv4 CIDR ranges to use on all ingress rules
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # List of egress rules to create by name
  egress_rules = ["all-all"]
  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "Allow Port 81 from internet"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  tags = local.common_tags
}