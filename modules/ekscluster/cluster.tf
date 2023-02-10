resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}


resource "aws_iam_role" "cluster_role" {
  name = "yh-eks-cluster"
  # create temporary credentials
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# This policy provides Kubernetes the permissions it requires to manage resources on your behalf. 
# Kubernetes requires Ec2:CreateTags permissions to place identifying information on EC2 resources
# including but not limited to Instances, Security Groups, and Elastic Network Interfaces.
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}

### Policy used by VPC Resource Controller to manage ENI and IPs for worker nodes.
resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_eks_node_group" "yh-node" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "yh-node"
  node_role_arn   = aws_iam_role.node-role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    # Desired max number of unavailable worker nodes during node group update.
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "node-role" {
  name = "yh-eks-node-group"

  assume_role_policy = jsonencode({
    Statement = [{
      # create temporary credentials
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

### This policy allows Amazon EKS worker nodes to connect to Amazon EKS Clusters.
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node-role.name
}

### This policy provides the Amazon VPC CNI Plugin the permissions it requires to modify the IP address configuration on your EKS worker nodes.
### CNI = Container Network Interface. Each pod gets an IP address belonging to a VPC subnet.
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node-role.name
}

### policy to allow the node to read from ECR
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node-role.name
}


# Install ArgoCD Helm Chart
resource "helm_release" "argocd" {
  name  = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "4.9.7"
  create_namespace = true

  values = [
    file("argocd/application.yaml")
  ]
}


# resource "helm_release" "argocd" {
#   name       = "argocd-helm"
#   namespace  = kubernetes_namespace.namespaces[1].metadata.0.name

#   repository = "https://argoproj.github.io/argo-helm"
#   chart      = "argo-cd"

#   set {
#     name  = "service.type"
#     value = "LoadBalancer"
#   }
#   set {
#     name  = "service.annotations.service\\.beta\\.kubernetes\\.io/do-loadbalancer-name"
#     # value = format("%s-nginx-ingress", var.cluster_name)
#     value = format("%s-nginx-ingress", "yh-cluster")
#   }
# }
