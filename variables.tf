variable "region" {
  description = "DigitalOcean region slug to provisoin ressources in"
  type = string
  default = "fra1"
}


variable "cluster_name" {
  description = "Name of the DOKS cluster"
  type = string
  default = "sddp-poc"
}


variable "node_size" {
  description = "Droplet size slug for the default node pool"
  type = string
  default = "s-2vcpu-2gb"
}


variable "node_count" {
  description = "Number of nodes in the default node pool"
  type = number
  default = 2
}
