# ############## 


# resource "kubernetes_config_map" "aws_auth" {
#   depends_on = [module.eks]

#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }
#     data = {
#         mapRoles = <<-EOT
#         - rolearn: arn:aws:iam::216282580084:role/eksClusterRoleRelq
#             username: eksClusterRoleRelq
#             groups:
#             - system:masters
#         EOT

#         mapUsers = <<-EOT
#         - userarn: arn:aws:iam::216282580084:user/Anzhela
#             username: Anzhela
#             groups:
#             - system:masters
#         EOT
#     }

# }


# # ######### kubernetes role  ####

# resource "kubernetes_role" "eks_role" {

#   metadata {
#     name      = "eks-role"
#     namespace = var.namespaces
#   }

#   rule {
#     api_groups = ["rbac.authorization.k8s.io"]
#     resources  = ["pods", "namespaces", "services", "deployments"]
#     verbs      = ["get", "list", "watch", "create", "update", "delete"]
#   }
# }

# resource "kubernetes_role_binding" "eks_role_binding" {

#   metadata {
#     name      = "eks_role"
#     namespace = var.namespaces
#   }

#   role_ref {
#     kind     = "Role"
#     name     = "eks_role"
#     api_group = "rbac.authorization.k8s.io"
#   }

#   subject {
#     kind      = "User"
#     name      = "arn:aws:iam::216282580084:user/Anzhela"
#     api_group = "rbac.authorization.k8s.io"
#   }
# }


# ########## cluster role ####

# resource "kubernetes_cluster_role" "cluster_role" {
#   metadata {
#     name = module.eks.cluster_iam_role_name
#   }

#   rule {
#     api_groups = [""]
#     resources  = ["pods"]
#     verbs      = ["get", "list", "watch", "create", "update", "delete"]
#   }
# }

# resource "kubernetes_cluster_role_binding" "role_binding" {
#   metadata {
#     name = "example-cluster-role-binding"
#   }

#   role_ref {
#     kind     = "ClusterRole"
#     name     = module.eks.cluster_iam_role_name
#     api_group = "rbac.authorization.k8s.io"
#   }

#   subject {
#     kind      = "User"
#     name      = "arn:aws:iam::216282580084:user/Anzhela"
#     api_group = "rbac.authorization.k8s.io"
#   }
# }



# #############################

# resource "aws_iam_role" "eks_cluster_role" {
#   name = "eks-cluster-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           Service = "eks.amazonaws.com"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_role_AmazonEKSClusterPolicy" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_role_AmazonEKSServicePolicy" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
# }


