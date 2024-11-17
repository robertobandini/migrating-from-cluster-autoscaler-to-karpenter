module "cluster_autoscaler" {
  source = "git::https://github.com/DNXLabs/terraform-aws-eks-cluster-autoscaler.git?ref=1.0.0"
  count = local.cluster_autoscaler_enabled ? 1 : 0

  cluster_name                     = module.eks.cluster_name
  cluster_identity_oidc_issuer     = module.eks.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
  aws_region                       = local.region
  helm_chart_version               = "9.37.0"

  settings = {
    "nodeSelector" : {
      "nodegroup" = "system"
    }
    "tolerations" : [
      {
        key      = "CriticalAddonsOnly"
        operator = "Exists"
      }
    ]
  }
}