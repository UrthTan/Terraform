# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet

module "ec2_private" {
  depends_on = [
    module.vpc
  ]
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.21.0"

  instance_count = var.private_instance_count
  name           = "${var.environment}-private-vm"
  ami            = data.aws_ami.amzlinux2.id
  instance_type  = var.instance_type
  key_name       = var.aws_key_pair_name
  user_data      = file("${path.module}/app-install.sh")
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]
  #subnet_id = module.vpc.private_subnets[count.index]
  vpc_security_group_ids = [module.private_sg.security_group_id]
  tags                   = local.common_tags
}