output "ec2_client_vpn_configuration" {
  sensitive = true
  value     = length(module.ec2_client_vpn) == 0 ? null : module.ec2_client_vpn[0].full_client_configuration
}