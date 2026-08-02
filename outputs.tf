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

output "registry_name" {
  description = "DOCR registry name"
  value       = digitalocean_container_registry.sddp.name
}

output "registry_endpoint" {
  description = "DOCR endpoint (registry.digitalocean.com/<name>) — base for image refs, the Week-3 promote target, and POL-04's allowlist"
  value       = digitalocean_container_registry.sddp.endpoint
}

output "registry_server_url" {
  description = "DOCR server URL (registry.digitalocean.com) — the host for docker login / imagePullSecrets"
  value       = digitalocean_container_registry.sddp.server_url
}
