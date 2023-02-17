### network variables
region = "eu-west-2"
vpc_name = "yh-vpc"
vpc_cidr = "10.10.0.0/16"
num_of_subnets = 2
subnet_cidr = ["10.10.10.0/24", "10.10.20.0/24", "10.10.30.0/24"]
subnet_azs = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]

### ekscluster variables
cluster_name = "yh-cluster"

### node variables
node_group_name = "yh-node"
instance_type = ["t3.2xlarge"]
group_max_size = 3
group_min_size = 1
group_desired_size = 3

# helm argocd vars
argocd_repo = "https://argoproj.github.io/argo-helm"
argocd_chart = "argo-cd"
argocd_namespace = "argocd"
argocd_create_namespace = true
argocd_version = "4.9.7"
argocd_application_path = "modules/ekscluster/argocd/application.yaml"
ssh_parameter_name = "private_key_yh"
argocd_repo_type = "git"
argocd_repo_url = "git@github.com:yotam-halperin/portfolio-charts.git"
argocd_repo_place = "github"

