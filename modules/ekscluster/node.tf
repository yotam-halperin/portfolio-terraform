
resource "aws_eks_node_group" "yh-node" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.node-role.arn
  subnet_ids      = var.subnet_ids
  instance_types = var.instance_type

  scaling_config {
    desired_size = var.group_desired_size
    max_size     = var.group_max_size
    min_size     = var.group_min_size
  }

  update_config {
    # Desired max number of unavailable worker nodes during node group update.
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.SecretsManagerReadWritenode,
    aws_iam_role_policy_attachment.IAMFullAccess,
  ]
}

resource "aws_iam_role" "yh-tls-node-role" {
  name = "yh-tls-node-role"
  # create temporary credentials
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::644435390668:role/${var.node_group_name}-node-role"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
### Provides full access to all Amazon Route 53 via the AWS Management Console.
resource "aws_iam_role_policy_attachment" "AmazonRoute53FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  role       = aws_iam_role.yh-tls-node-role.name
}

# ARN == arn:aws:iam::644435390668:role/yh-eks-node-group
resource "aws_iam_role" "node-role" {
  name = "${var.node_group_name}-node-role"

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

### Provides read/write access to AWS Secrets Manager via the AWS Management Console.
resource "aws_iam_role_policy_attachment" "SecretsManagerReadWritenode" {
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  role       = aws_iam_role.node-role.name
}


### Provides full access to all Amazon Route 53 via the AWS Management Console.
resource "aws_iam_role_policy_attachment" "IAMFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
  role       = aws_iam_role.node-role.name
}