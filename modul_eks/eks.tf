module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true  #TODO change to private
  

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
  subnet_ids = [local.public_subnets1_id, local.public_subnets2_id]
  vpc_id                   = local.project_vpc_id
 
  control_plane_subnet_ids = [local.private_subnets1_id, local.private_subnets2_id]

  # EKS Managed Node Group(s)
#   eks_managed_node_group_defaults = {
#     instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
#   }

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

  # Cluster access entry
  # To add the current caller identity as an administrator
  #enable_cluster_creator_admin_permissions = true


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

  # tags = {
  #   Environment = "default"
  #   Terraform   = "true"
  # }
}



########### Namespaces #############

# # Create namespaces in kubernetes cluster
# resource "kubernetes_namespace" "example" {

#   metadata {
#     name = var.namespaces
#   }
# }