module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true   # Change it to false if deploying for production environment  
  

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
  subnet_ids               = [local.private_subnets1_id, local.private_subnets2_id]
  vpc_id                   = local.project_vpc_id
 
  control_plane_subnet_ids = [local.private_subnets1_id, local.private_subnets2_id]


  eks_managed_node_groups = {
    
    node_group1 = {
      name         = "eks-node"
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t2.small"]
      capacity_type  = "ON_DEMAND"
    }
  }

  enable_irsa = true

  iam_role_arn = aws_iam_role.eks_node_role.arn

  access_entries = {
    # One access entry with a policy associated

    entry1 = {
      principal_arn     = "arn:aws:iam::216282580084:user/Anzhela"

      policy_associations = {
        entry_policy = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            namespaces = []
            type       = "cluster"
          }
        }
        
      }
    }
  }
}
