locals {
  name   = "test-karpenter"
  region = "eu-west-3"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  cluster_autoscaler_enabled = false
  karpenter_enabled          = false
  
  ec2_client_vpn_enabled = true
  vpn_allowed_cidr_blocks = ["xxx.xxx.xxx.xxx/32"]

  tags = {
    Test = "test-karpenter"
  }
}