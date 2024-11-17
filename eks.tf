module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.20.0"

  cluster_name    = "${local.name}-eks"
  cluster_version = "1.30"

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    aws-ebs-csi-driver     = {}
    vpc-cni                = {
      configuration_values = jsonencode({
        enableWindowsIpam   = "true"
      })
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    system = {
      instance_types = ["m5.large"]
      
      min_size = 2
      max_size = 4
      desired_size = 2

      labels = {
        nodegroup = "system"
      }

      taints = [
        {
           key    = "CriticalAddonsOnly"
           value  = "system"
           effect = "NO_SCHEDULE"
        }
      ]

      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
      
      tags = {
        nodegroup = "system"
      }
    }
    workloads = {
      instance_types = ["m5.large"]
      
      min_size = 1
      max_size = 10
      desired_size = 1

      labels = {
        nodegroup = "workloads"
      }

      taints = [
        {
           key    = "type",
           value  = "workloads"
           effect = "NO_SCHEDULE"
        }
      ]
      
      tags = {
        nodegroup = "workloads"
      }
    }
  }

  node_security_group_tags = merge(local.tags, {
    "karpenter.sh/discovery" = "${local.name}-eks"
  })

  tags = local.tags
}