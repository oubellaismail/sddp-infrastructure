provider "helm" {
  kubernetes {
    host = digitalocean_kubernetes_cluster.sddp.kube_config[0].host
    token = digitalocean_kubernetes_cluster.sddp.kube_config[0].token
    cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.sddp.kube_config[0].cluster_ca_certificate)
  }
}

resource "helm_release" "argocd" {
  name = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  namespace = "argocd"
  create_namespace = true
  version = "10.2.1"
}
