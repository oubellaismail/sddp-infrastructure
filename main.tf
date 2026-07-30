terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = "~> 2.0"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
}

provider "digitalocean" {}

resource "digitalocean_vpc" "sddp" {
  name = "${var.cluster_name}-vpc"
  region = var.region
  ip_range = "10.0.0.0/16"
}

data "digitalocean_kubernetes_versions" "current" {}

resource "digitalocean_kubernetes_cluster" "sddp" {
  name = var.cluster_name
  region = var.region
  version = data.digitalocean_kubernetes_versions.current.latest_version 
  vpc_uuid = digitalocean_vpc.sddp.id

  node_pool {
    name = "${var.cluster_name}-pool"
    size = var.node_size
    node_count = var.node_count
  }
}


