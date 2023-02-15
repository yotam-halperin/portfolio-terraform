
module "network" {

  source = "./modules/network"  

  region = lookup(var.region, terraform.workspace)
  
  vpc_name = lookup(var.vpc_name, terraform.workspace)
  vpc_cidr = lookup(var.vpc_cidr, terraform.workspace)

  num_of_subnets = var.num_of_subnets

  subnet_azs = lookup(var.subnet_azs, terraform.workspace)
  subnet_cidr = lookup(var.subnet_cidr, terraform.workspace)
  
}


module "ekscluster" {

  source = "./modules/ekscluster"
  depends_on = [module.network]

  cluster_name = lookup(var.cluster_name, terraform.workspace)
  subnet_ids = module.network.subnets
  node_group_name = lookup(var.node_group_name, terraform.workspace)
  instance_type = var.instance_type
  group_max_size = lookup(var.group_max_size, terraform.workspace)
  group_min_size = lookup(var.group_min_size, terraform.workspace)
  group_desired_size = lookup(var.group_desired_size, terraform.workspace)
  argocd_repo = var.argocd_repo
  argocd_chart = var.argocd_chart
  argocd_namespace = var.argocd_namespace
  argocd_create_namespace = var.argocd_create_namespace
  argocd_version = var.argocd_version
  argocd_application_path = var.argocd_application_path
  ssh_parameter_name = var.ssh_parameter_name
  argocd_repo_type = var.argocd_repo_type
  argocd_repo_url = var.argocd_repo_url
  argocd_repo_place = var.argocd_repo_place
}



