provider "helm" {
  kubernetes {
    host                   = digitalocean_kubernetes_cluster.sddp.kube_config[0].host
    token                  = digitalocean_kubernetes_cluster.sddp.kube_config[0].token
    cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.sddp.kube_config[0].cluster_ca_certificate)
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "10.2.1"

  # Explicit resource requests/limits for every ArgoCD component so they
  # satisfy POL-03 (require-resource-limits) — ArgoCD is a "system component
  # gets a proper tier", not exempt. Requests + memory limits only, no CPU
  # limits, matching POL-03 spec v1.2 (CPU is compressible; a CPU limit only
  # throttles). Sized modestly for the 2 vCPU / 2 GB DOKS nodes; the heavier
  # controller/repo-server get more memory headroom (repo-server renders the
  # Kyverno Helm chart, which is large).
  values = [yamlencode({
    controller = {
      # The application-controller caches live cluster state and grew past 512Mi
      # as more apps/policies came under management — it was OOMKilled (exit 137)
      # in a restart loop, wedging syncs. Bumped to a 1Gi limit (POL-03 large-tier
      # ceiling: mem request <=512Mi, mem limit <=1Gi) with a 256Mi request for
      # headroom. Still no CPU limit (POL-03 spec v1.2).
      resources = {
        requests = { cpu = "100m", memory = "256Mi" }
        limits   = { memory = "1Gi" }
      }
    }
    repoServer = {
      resources = {
        requests = { cpu = "100m", memory = "128Mi" }
        limits   = { memory = "512Mi" }
      }
    }
    server = {
      resources = {
        requests = { cpu = "50m", memory = "64Mi" }
        limits   = { memory = "256Mi" }
      }
    }
    applicationSet = {
      resources = {
        requests = { cpu = "50m", memory = "64Mi" }
        limits   = { memory = "256Mi" }
      }
    }
    notifications = {
      resources = {
        requests = { cpu = "50m", memory = "64Mi" }
        limits   = { memory = "256Mi" }
      }
    }
    dex = {
      resources = {
        requests = { cpu = "50m", memory = "64Mi" }
        limits   = { memory = "256Mi" }
      }
    }
    redis = {
      resources = {
        requests = { cpu = "50m", memory = "64Mi" }
        limits   = { memory = "256Mi" }
      }
    }
  })]
}
