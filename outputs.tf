# Populated in INFRA-003 once the digitalocean_kubernetes_cluster resource exists.
# Planned outputs: cluster id/endpoint, region, kubeconfig retrieval hint.

output "cluster_id" {
  description = "DOKS cluster ID"
  value       = digitalocean_kubernetes_cluster.sddp.id
}

output "cluster_endpoint" {
  description = "DOKS cluster API server endpoint"
  value       = digitalocean_kubernetes_cluster.sddp.endpoint
}

output "cluster_region" {
  description = "Region the cluster is provisioned in"
  value       = digitalocean_kubernetes_cluster.sddp.region
}
