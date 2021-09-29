# AWS EC2 Security Group Terraform Module
# Security Group for Private Bastion Host
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.3.0"

  name        = "private_sg"
  description = "Security group with HTTP & SSH ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Block  
  # List of ingress rules to create by name
  ingress_rules = ["ssh-tcp", "http-80-tcp"]
  # List of IPv4 CIDR ranges to use on all ingress rules
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  # List of egress rules to create by name
  egress_rules = ["all-all"]
  tags         = local.common_tags
}