variable "region" {
  description = "DigitalOcean region slug to provisoin ressources in"
  type        = string
  default     = "fra1"
}


variable "cluster_name" {
  description = "Name of the DOKS cluster"
  type        = string
  default     = "sddp-poc"
}


variable "node_size" {
  description = "Droplet size slug for the default node pool"
  type        = string
  default     = "s-2vcpu-4gb"
}


variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}


variable "argocd_repo_ssh_private_key" {
  description = "SSH private key for ArgoCD's read-only deploy key on sddp-platform-config"
  type        = string
  sensitive   = true
}


variable "argocd_app_config_ssh_private_key" {
  description = "SSH private key for ArgoCD's read-only deploy key on sddp-app-config"
  type        = string
  sensitive   = true
}


variable "registry_name" {
  description = "DOCR registry name — globally unique across all DigitalOcean customers; becomes registry.digitalocean.com/<name>"
  type        = string
  default     = "sddp-registry"
}


variable "infisical_client_id" {
  description = "Infisical machine-identity (Universal Auth) client ID — External Secrets Operator uses it to read secrets from the Infisical Cloud project"
  type        = string
  sensitive   = true
}


variable "infisical_client_secret" {
  description = "Infisical machine-identity (Universal Auth) client secret — the single standing bootstrap credential ESO logs in with"
  type        = string
  sensitive   = true
}
