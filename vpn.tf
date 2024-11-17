module "ec2_client_vpn" {
  source  = "cloudposse/ec2-client-vpn/aws"
  version = "1.0.0"
  count   = local.ec2_client_vpn_enabled ? 1 : 0

  ca_common_name     = "vpn.internal.${local.name}.com"
  root_common_name   = "vpn-client.internal.${local.name}.com"
  server_common_name = "vpn-server.internal.${local.name}.com"

  client_cidr                   = "10.1.0.0/22"
  organization_name             = local.name
  logging_stream_name           = local.name
  associated_subnets            = module.vpc.private_subnets
  vpc_id                        = module.vpc.vpc_id
  export_client_certificate     = true
  transport_protocol            = "tcp"
  split_tunnel                  = true
  allowed_cidr_blocks           = local.vpn_allowed_cidr_blocks
  associated_security_group_ids = [module.eks.cluster_primary_security_group_id]
  authorization_rules           = [
    {
      name                 = local.name
      authorize_all_groups = true
      description          = local.name
      target_network_cidr  = local.vpc_cidr
    }
  ]

  tags = local.tags
}