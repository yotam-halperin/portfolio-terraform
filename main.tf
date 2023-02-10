
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
}



