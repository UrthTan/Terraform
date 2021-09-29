# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_bastion.id
}
output "ec2_bastion_public_ip" {
  description = "List of Public ip address assigned to the instances"
  value       = module.ec2_bastion.public_ip
}
# Private EC2 Instances
# output "ec2_private_instance_ids" {
#   description = "List of IDs of instances"
#   value       = [for s in module.ec2_private : s.id]
# }
# output "ec2_private_ip" {
#   description = "List of private ip address assigned to the instances"
#   value       = [for s in module.ec2_private : s.private_ip]
# }

# Private EC2 Instances
# ec2_private_instance_ids
output "ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_private.id
}
## ec2_private_ip
output "ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = module.ec2_private.private_ip
}
