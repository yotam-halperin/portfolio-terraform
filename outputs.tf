output "region" {
  value       = module.network.region
  depends_on  = [module.network]
}

output "cluster_name" {
    value       = module.ekscluster.cluster_name
    depends_on  = [module.ekscluster]
}

